#ifndef _COMMAND_H_
#define _COMMAND_H_

void CommandBegin();
void CommandLoop();

bool CommandCanSend();
void CommandSend(size_t(*cb)(char* buffer, size_t size, bool talk_at_will));

#endif
