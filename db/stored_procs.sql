-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rentrack_development`.`delete_reservation`(IN reservation_id INT)
BEGIN
    #Delete the mission
    DELETE FROM mission
    WHERE mission.reservation_id = reservation_id;

    #Delete the mission sheet
    DELETE mission_sheet
    FROM 
    mission INNER JOIN mission_sheet ON
    mission.id = mission_sheet.mission_id
    WHERE mission.reservation_id = reservation_id;

    #Delete the payment associated
    DELETE payment 
    FROM 
    payment INNER JOIN invoice ON
    payment.invoice_id = invoice.id
    WHERE invoice.reservation_id = reservation_id;

    DELETE invoice_tax
    FROM 
    invoice_tax INNER JOIN
    invoice ON invoice_tax.invoice_id = invoice.id
    WHERE invoice.reservation_id = reservation_id;

    #Once the invoice details are deleted, we delete the invoice
    DELETE FROM invoice
    WHERE invoice.reservation_id = reservation_id;

    #Delete from the reservation table
    DELETE FROM reservation
    WHERE reservation.id = reservation_id;
END


-- --------------------------------------------------------------------------------
-- Routine DDL
-- Note: comments before and after the routine body will not be stored by the server
-- --------------------------------------------------------------------------------
DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SELECT_INVOICE_INFO`(IN passed_client_id INT, IN start_date DATETIME, IN end_date DATETIME)
BEGIN
    SELECT actual_start_time, actual_end_time, start_odometer, end_odometer
    FROM mission_sheet

    INNER JOIN mission
    ON mission_sheet.mission_id = mission.id

    INNER JOIN reservation
    ON mission.reservation_id = reservation.id
    AND reservation.id = passed_client_id

    INNER JOIN invoice
    ON reservation.id = invoice.reservation_id

    WHERE (invoice.date < end_date) AND (invoice.date > start_date);
END

SELECT SUM(((end_odometer - start_odometer) * 

(SELECT amt FROM
mission
INNER JOIN truck
ON mission.truck_id = truck.id
INNER JOIN truck_type
ON truck.truck_type_id = truck_type.id
INNER JOIN cost
ON truck_type.id = cost.truck_type_id
INNER JOIN cost_type
ON cost.cost_type_id = cost_type.id
WHERE cost_type.name LIKE 'KM'
)

) +

(DATEDIFF(actual_end_time, actual_start_time) * 

(SELECT amt FROM
mission
INNER JOIN truck
ON mission.truck_id = truck.id
INNER JOIN truck_type
ON truck.truck_type_id = truck_type.id
INNER JOIN cost
ON truck_type.id = cost.truck_type_id
INNER JOIN cost_type
ON cost.cost_type_id = cost_type.id
WHERE cost_type.name LIKE 'Duration')

)) AS cost_reservation

FROM
mission
INNER JOIN mission_sheet
ON mission.id = mission_sheet.mission_id
WHERE mission.reservation_id = reservation_id
GROUP BY reservation_id
