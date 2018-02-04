CC=solc

compile: DelegatableVoting.sol
	$(CC) --overwrite --bin -o DelegatableVoting.bin $<
