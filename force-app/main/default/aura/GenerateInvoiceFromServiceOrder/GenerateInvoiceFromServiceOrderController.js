({
    myAction : function(component, event, helper) {
        var msg ='Are you sure you want to generate Invoice ?';
        if (confirm(msg)){
            var soId = component.get('v.recordId');
            // console.log('Service Order Id: '+soId);
            var action = component.get('c.CheckServiceOrderStatus');
            action.setParams({
                "Recid":soId
            });
            action.setCallback(this, function(response){
                var state = response.getState();
                if (state == "SUCCESS"){
                    var data = response.getReturnValue();
                    var soStatus = data[0].ChikPeaTOM__Status__c;
                    if(soStatus == "In Process"){
                        var soId = component.get('v.recordId');
                        var SoList = [];
                        SoList.push(soId);

                        var action = component.get('c.GetInvoice');
                        action.setParams({
                            "soId":SoList
                        });
                        action.setCallback(this, function(response){
                            var state = response.getState();
                            if (state === "SUCCESS"){
                                var data = response.getReturnValue();
                                var Invidx = data.Invlist[0].Id;
                                console.log("Data::  "+JSON.stringify(data));
                                if(data.Error){
                                    if(Invidx){
                                        alert('Invoice created with error\n'+ data.ErrorMsg);
                                    }
                                    else{
                                        alert(data.ErrorMsg);
                                    }
                                }

                                var navEvt = $A.get("e.force:navigateToSObject");
                                navEvt.setParams({
                    
                                    "recordId": Invidx,
                                    "slideDevName": "detail"
                                });
                                navEvt.fire();
                            }
                            else if (state === "ERROR"){
                                var errors = response.getError();
                                alert(errors);
                                var toastEvent = $A.get("e.force:showToast");
                                toastEvent.setParams({
                                    message: 'Something went wrong!',
                                    messageTemplate: 'Record {0} created! See it {1}!',
                                    duration:' 5000',
                                    key: 'info_alt',
                                    type: 'error',
                                    mode: 'pester'
                                });
                                toastEvent.fire();
                            }
                        });
                        $A.enqueueAction(action);
                    }
                    
                }
                
            });
            $A.enqueueAction(action);
            
              
        }
    }
})