# The Transaction class is meant to be used in a linked-list sort of fashion.
# The root transaction is the final transaction in the chain, and the current
# transaction is referenced by main. From here, all of the functions can be 
# carried out directly or recursively

class Transaction:
    def __init__ (self, parent):
        self.database   = {}
        self.valuecount = {}
        self.parent     = parent

    def set (self, key, value):
        # Update the value count for the new value
        self.increment(value)

        # If the key was previously defined, decrement its value count
        oldValue = self.get(key)
        if oldValue != None:
            self.decrement(oldValue)

        # Update the new key-value binding
        self.database[key] = value

    def get (self, key):
        # Recursively attempt to find the key until there are no more parents
        if key in self.database:
            return self.database[key]
        elif self.parent != None:
            return self.parent.get(key)
        else:
            return None

    def unset (self, key):
        # Decrement the value count for the current value if it exists
        value = self.get(key)
        if value != None:
            self.decrement(value)

        # Update the current binding to None
        self.database[key] = None

    def numEqualTo (self, value):
        # Recursively sum the value count for all Transactions
        if value in self.valuecount:
            if self.parent != None:
                return self.valuecount[value] + self.parent.numEqualTo(value)
            else:
                return self.valuecount[value]
        else:
            if self.parent != None:
                return self.parent.numEqualTo(value)
            else:
                return 0

    def createChild (self):
        return Transaction(self)

    def commit (self, newBindings):
        # Recusively pass and update bindings to parents until root is reached
        if self.parent != None:
            for key in newBindings.keys():
                self.database[key] = newBindings[key]
            return self.parent.commit(self.database)
        else:
            for key in newBindings.keys():
                self.set(key, newBindings[key])
            return self

    # Helper functions for updating count values in dictionaries
    def increment (self, value):
        if value in self.valuecount:
            self.valuecount[value] += 1
        else:
            self.valuecount[value]  = 1

    def decrement (self, value):
        if value in self.valuecount:
            self.valuecount[value] -= 1
        else:
            self.valuecount[value] = -1

