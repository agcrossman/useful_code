/**
* Author:       Ben Edwards (Tquila)
* Date:         29/05/2015
* Description:  Universal scheduler class to schedule batch classes
*
* ******************* Example Use  *******************
* 	
* 		// Intiate scheduler
* 		BatchScheduler scheduler = new BatchScheduler(new AddressValidationBatchAccount(), 200);
*
*		// Run every day at 1pm
*		System.schedule('MyBatch - Everyday at 1pm', '0 0 13 * * ?', scheduler);
*
**/
global class BatchScheduler implements Schedulable {

	// The name of the batch class to schedule
	global Database.Batchable<SObject> batchClass	{get;set;}

	// The size of the batches to run for the batch class
	global Integer batchSize	{get;set;}

	// Constructor for the batch class. Set the class name and batch size.
	global BatchScheduler(Database.Batchable<SObject> batch, Integer size) {

		batchClass = batch;
		batchSize = size;

	}

	// Execute method for the class
	global void execute(SchedulableContext sc) {

		database.executeBatch(batchClass, batchSize);
  	
  	}

}