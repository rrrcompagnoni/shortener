# Alias Creation

## Implementation overview

![Implementation overview](alias_creation.png)

## How to use

1. [Access the root page](http://localhost:4000/)
2. Type or paste any valid URI schema in the form.
3. Click on Short it button.
4. You should be redirected to the Alias created.
5. Copy the Alias or just access it.

## Notes

1. There is an automatic conflict resolution when there is an ID collision. That resolution function should change the ID picked every time.
2. You can pass an optional ID to the insert function. That enables ID customization.
3. The Alias ID inventory implementation takes a random ID. It doesn't check inventory. A more robust implementation should rely on a previous created inventory with allocation constraints.
