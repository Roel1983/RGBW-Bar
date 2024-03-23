package nl.rdrost.rgbw.comm.layers.session;

import java.io.Closeable;
import java.io.IOException;
import java.util.BitSet;
import java.util.Objects;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingDeque;

import nl.rdrost.rgbw.comm.layers.command.Receiver;
import nl.rdrost.rgbw.comm.layers.command.RequestToSendCommand;
import nl.rdrost.rgbw.comm.layers.command.RequestToSendResponseCommand;
import nl.rdrost.rgbw.comm.layers.command.Sender;
import nl.rdrost.rgbw.comm.layers.command.details.AbstractCommand;

public class Communication implements Closeable{
	
	private final Sender   sender;
	private final Receiver receiver;
	
	private final Thread sending_thread;
	private final Thread receiving_thread;
	private final BlockingQueue<AbstractCommand> command_queue;
	private final BlockingQueue<RequestToSendResponseCommand> request_for_higher_requested_length;
		
	public Communication(final Sender sender, final Receiver receiver) {
		Objects.nonNull(sender);
		Objects.nonNull(receiver);
		
		this.sender   = sender;
		this.receiver = receiver;
		
		this.command_queue    = new LinkedBlockingDeque<>(100);
		this.request_for_higher_requested_length = new LinkedBlockingDeque<>(10);
		
		this.sending_thread   = new Thread(new SendingRunnable());
		this.receiving_thread = new Thread(new ReceivingRunnable());
		
		sending_thread.start();
		receiving_thread.start();
	}
	
	@Override
	public void close() throws IOException {
		this.receiver.close();
		this.sending_thread.interrupt();
		this.receiving_thread.interrupt();
	}
	
	public void send(final AbstractCommand command) {
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
					if(command_or_null != null) {
						System.out.println(String.format("-->: %s", command_or_null));
						Communication.this.sender.send(command_or_null);
					} else {
						RequestToSendResponseCommand request_to_send_response = 
								request_for_higher_requested_length.poll();
//						if (request_to_send_response != null) {
//							final RequestToSendCommand requestToSendCommand = new RequestToSendCommand(
//									request_to_send_response.getSenderUniqueId(),
//									request_to_send_response.getRequestedLength());
//							//System.out.println(String.format("-->: %s", requestToSendCommand));
//							Communication.this.sender.send(requestToSendCommand);
//							Thread.sleep(request_to_send_response.getRequestedLength() / 4);
//						} else {
//							final int unique_id_to_try = nextUniqueIdToTry();
//							Communication.this.sender.send(new RequestToSendCommand(
//									unique_id_to_try,
//									8));
//						}
						Thread.sleep(2);
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
					final AbstractCommand command = Communication.this.receiver.getCommand_queue().take();
					
					synchronized (known_ids) {
						final int unique_id = command.getSenderUniqueId();   
						if (!known_ids.get(unique_id)) {
							System.out.println(String.format("found: %d", unique_id));
							known_ids.set(unique_id);
						}
					}
					
					if (command instanceof RequestToSendResponseCommand) {
						RequestToSendResponseCommand requestToSendResponseCommand = 
								(RequestToSendResponseCommand)command;
						if (requestToSendResponseCommand.getRequestedLength() > 0) {
							Communication.this.request_for_higher_requested_length.offer(
									requestToSendResponseCommand);
						}
					}
					//System.out.println(String.format("<--: %s", command));
				} catch (InterruptedException e) {
					Thread.currentThread().interrupt();
				}
			}
		}
	}
}
