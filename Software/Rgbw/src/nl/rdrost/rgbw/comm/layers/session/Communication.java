package nl.rdrost.rgbw.comm.layers.session;

import java.io.Closeable;
import java.io.IOException;
import java.util.BitSet;
import java.util.List;
import java.util.Objects;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingDeque;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

import nl.rdrost.rgbw.comm.layers.command.Receiver;
import nl.rdrost.rgbw.comm.layers.command.RequestToSendCommand;
import nl.rdrost.rgbw.comm.layers.command.RequestToSendResponseCommand;
import nl.rdrost.rgbw.comm.layers.command.Sender;
import nl.rdrost.rgbw.comm.layers.command.details.AbstractCommand;

public class Communication implements Closeable {
	
	public enum DebugPrint {
		OFF,
		ON,
		ON_ALL
	};
	
	private final Sender   inner_sender;
	private final Receiver inner_receiver;
	
	private final Thread sending_thread;
	private final Thread receiving_thread;
	private final BlockingQueue<AbstractCommand> command_queue;
	private final BlockingQueue<RequestToSendResponseCommand> request_for_higher_requested_length;
	
	private volatile boolean is_send_on_command       = false;
	private volatile boolean is_request_stop_sender   = false;
	private volatile boolean is_scan_complete         = false;
	
	private volatile DebugPrint debug_print_sender   = DebugPrint.OFF;
	private volatile DebugPrint debug_print_receiver = DebugPrint.OFF;
		
	public Communication(final Sender inner_sender, final Receiver inner_receiver) {
		Objects.nonNull(inner_sender);
		Objects.nonNull(inner_receiver);
		
		this.inner_sender   = inner_sender;
		this.inner_receiver = inner_receiver;
		
		this.command_queue    = new LinkedBlockingDeque<>(100);
		this.request_for_higher_requested_length = new LinkedBlockingDeque<>(10);
		
		this.sending_thread   = new Thread(new SendingRunnable());
		this.receiving_thread = new Thread(new ReceivingRunnable());
		
		this.is_request_stop_sender   = false;
		this.sending_thread.start();
		this.receiving_thread.start();		
	}
	
	public void setSendOnRequest(final boolean is_send_on_command) {
		this.is_send_on_command = is_send_on_command;
	}

	public boolean isScanComplete() {
		return this.is_scan_complete;
	}
	
	public void waitTillScanComplete() {
		while(!this.is_scan_complete) {
			try {
				Thread.sleep(10);
			} catch (InterruptedException e) {
				Thread.currentThread().interrupt();
				return;
			}
		}
	}
	
	public List<Integer> getDeviceIds() {
		synchronized (known_ids) {
			return this.known_ids.stream().boxed().collect(Collectors.toList());
		}
	}
	
	@Override
	public void close() throws IOException {
		try {
			this.is_request_stop_sender = true;
			this.sending_thread.join();
			this.inner_sender.close();
		} catch (InterruptedException e) {
			this.sending_thread.interrupt();				
			this.receiving_thread.interrupt();
			Thread.currentThread().interrupt();
		}
		this.inner_receiver.close();
		this.receiving_thread.interrupt();
	}
	
	public final boolean getSendOnCommand() {
		return this.is_send_on_command;
	}
	
	public void setDebugPrintReceiver(DebugPrint debug_print_receiver) {
		Objects.nonNull(debug_print_receiver);
		this.debug_print_receiver = debug_print_receiver;
	}
	
	public void setDebugPrintSender(DebugPrint debug_print_sender) {
		Objects.nonNull(debug_print_sender);
		this.debug_print_sender = debug_print_sender;
	}
	
	public void send(final AbstractCommand command) {
		if (is_request_stop_sender) {
			throw new IllegalStateException();
		}
		try {
			command_queue.put(command);
		} catch (InterruptedException e) {
			Thread.currentThread().interrupt();
		}
	}
	
	private int    next_candidate_know_id = 0;
	private int    next_candidate_unknow_id = 0;
	private BitSet known_ids = new BitSet(0xFE);
	
	private class SendingRunnable implements Runnable {

		@Override
		public void run() {
			while(!Thread.interrupted()) {
				AbstractCommand command_or_null = Communication.this.command_queue.poll();
				
				try {
					Thread.sleep(20); // Why is this needed why is the sleep after 
					if(command_or_null != null) {
						if (debug_print_sender != DebugPrint.OFF) {
							System.out.println(String.format("-->: %s", command_or_null));
						}
						Communication.this.inner_sender.send(command_or_null);
					} else if (Communication.this.is_send_on_command) {
						if (Communication.this.is_request_stop_sender 
								&& Communication.this.command_queue.isEmpty()) 
						{
							break;
						}						
						RequestToSendResponseCommand request_to_send_response = 
								request_for_higher_requested_length.poll();
						if (request_to_send_response != null) {
							final RequestToSendCommand requestToSendCommand = new RequestToSendCommand(
									request_to_send_response.getSenderUniqueId(),
									request_to_send_response.getRequestedLength());
							if (debug_print_sender == DebugPrint.ON_ALL) {
								System.out.println(String.format("-->: %s", requestToSendCommand));
							}
							Communication.this.inner_sender.send(requestToSendCommand);
							Communication.this.inner_sender.flush();
							Thread.sleep(request_to_send_response.getRequestedLength() / 4);
						} else {
							final int unique_id_to_try = nextUniqueIdToTry();
							final RequestToSendCommand requestToSendCommand = 
									new RequestToSendCommand(
										unique_id_to_try,
										8); 
							if (debug_print_sender == DebugPrint.ON_ALL) {
								System.out.println(String.format("-->: %s", requestToSendCommand));
							}
							Communication.this.inner_sender.send(requestToSendCommand);
							Communication.this.inner_sender.flush();
							Thread.yield();
						}
						Thread.sleep(4);
					}
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (InterruptedException e) {
					Thread.currentThread().interrupt();
				}
			}
		}
	}
	
	private int nextUniqueIdToTry() {
		synchronized (known_ids) {
			final int next_known_id = known_ids.nextSetBit(next_candidate_know_id);
			if (next_known_id >= 0) {
				next_candidate_know_id = next_known_id + 1;
				return next_known_id;
			} else {
				next_candidate_know_id = 0;
				
				final int next_unknown_id = known_ids.nextClearBit(next_candidate_unknow_id);
				if (next_unknown_id >= 0 && next_unknown_id <= 0xfe) {
					next_candidate_unknow_id = next_unknown_id + 1;
					return next_unknown_id;
				} else {
					next_candidate_unknow_id = 0;
					if (!is_scan_complete) {
						new Thread(()->{
							try {
							    TimeUnit.MILLISECONDS.sleep(100);
							    is_scan_complete = true;
							} catch (InterruptedException ie) {}							
						}).start();
					};
					return nextUniqueIdToTry();
				}							
			}
		}
	}
	
	private class ReceivingRunnable implements Runnable {

		@Override
		public void run() {
			while(!Thread.interrupted()) {
				try {
					final AbstractCommand command = Communication.this.inner_receiver.getCommand_queue().take();
					
					synchronized (known_ids) {
						final int unique_id = command.getSenderUniqueId();   
						if (!known_ids.get(unique_id)) {
							known_ids.set(unique_id);
						}
					}
					
					if (command instanceof RequestToSendResponseCommand) {
						if (debug_print_receiver == DebugPrint.ON_ALL) {
							System.out.println(String.format("<--: %s", command));
						}
						RequestToSendResponseCommand requestToSendResponseCommand = 
								(RequestToSendResponseCommand)command;
						if (requestToSendResponseCommand.getRequestedLength() > 0) {
							Communication.this.request_for_higher_requested_length.offer(
									requestToSendResponseCommand);
						}
					} else {
						if (debug_print_receiver != DebugPrint.OFF) {
							System.out.println(String.format("<--: %s", command));
						}
					}
				} catch (InterruptedException e) {
					Thread.currentThread().interrupt();
				}
			}
		}
	}
}
