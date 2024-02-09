-- Transaction Control
/*
- a transaction is a sequence of operations performed as a single logical unit of work 
- a transaction usually means that the data in the database has changed.
- a transaction has only two results: success or failure

Commands:
- COMMIT: Saves changes made during the transaction to the database.
- ROLLBACK: Discards changes made during the transaction and restores the database to its state before the transaction began.
- SAVEPOINT: Sets a point within the transaction to which you can later rollback. SAVEPOINT sp1;
- SET TRANSACTION: change transaction options like isolation level and what kind of lock to use
- Rollback is possible of dml commands only
        ROLLBACK TO SAVEPOINT sp1;
- AUTOCOMMIT: Automatically commits each SQL statement as a separate transaction. Turned on by default in some systems.
        SET AUTOCOMMIT OFF;
- RELEASE SAVEPOINT: Removes a savepoint from the transaction.
        RELEASE SAVEPOINT sp1;

*/

-- Begin the transaction
BEGIN TRANSACTION;

-- Withdraw money from account A
UPDATE accounts SET balance = balance - 100 WHERE account_id = 'A';

-- Deposit money into account B
UPDATE accounts SET balance = balance + 100 WHERE account_id = 'B';

-- Commit the transaction if both updates succeed
COMMIT;
-- Rollback the transaction if any update fails
ROLLBACK;



-- EG.

-- Begin the transaction
BEGIN TRANSACTION;

-- Set the isolation level to Serializable for consistency
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

-- Savepoint before deducting items from inventory
SAVEPOINT before_deduct_inventory;

-- Deduct items from inventory for the ordered products
UPDATE inventory 
SET quantity = quantity - 1 
WHERE product_id = 'XYZ' AND quantity >= 1;

-- Check if the update affected any rows, if not, rollback to the savepoint
IF SQL%ROWCOUNT = 0 THEN
    ROLLBACK TO SAVEPOINT before_deduct_inventory;
    RAISE_APPLICATION_ERROR(-20001, 'Insufficient inventory');
END IF;

-- Savepoint before updating the order status
SAVEPOINT before_update_order_status;

-- Update the order status to 'Shipped'
UPDATE orders 
SET status = 'Shipped' 
WHERE order_id = '123' AND status = 'Pending';

-- Check if the update affected any rows, if not, rollback to the savepoint
IF SQL%ROWCOUNT = 0 THEN
    ROLLBACK TO SAVEPOINT before_update_order_status;
    RAISE_APPLICATION_ERROR(-20002, 'Failed to update order status');
END IF;

-- Commit the transaction if all updates succeed
COMMIT;
-- Rollback the transaction if any update fails
ROLLBACK;
