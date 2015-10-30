import sys
from transaction import Transaction

if __name__ == '__main__': 
    transaction = Transaction(None)

    line = sys.stdin.readline().rstrip()
    while line != "END":
        try:
            args = line.split()
            if args[0] == "SET":
                key = args[1]
                value = args[2]
                transaction.set(key, value)
            elif args[0] == "GET":
                key = args[1]
                value = transaction.get(key)
                print value if value != None else "NULL"
            elif args[0] == "UNSET":
                key = args[1]
                transaction.unset(key)
            elif args[0] == "NUMEQUALTO":
                value = args[1]
                print str(transaction.numEqualTo(value))
            elif args[0] == "BEGIN":
                transaction = transaction.createChild()
            elif args[0] == "COMMIT":
                transaction = transaction.commit({})
            elif args[0] == "ROLLBACK":
                if transaction.parent != None:
                    transaction = transaction.parent
                else:
                    print "NO TRANSACTION"
            else:
                raise Exception("Bad argument passed")
        except:
            print "Command not recognized or malformed"
            print "Commands: SET, GET, UNSET, NUMEQUALTO, BEGIN, COMMIT, ROLLBACK, END"
        finally:
            line = sys.stdin.readline().rstrip()

