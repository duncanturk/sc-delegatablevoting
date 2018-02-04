CC=solc

compile: DelegatableVoting.sol ExtendedInt.sol
	$(CC) --overwrite --bin -o DelegatableVoting.bin $<
