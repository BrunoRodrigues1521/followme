exports.isValid = function(value,type){

    if(value == undefined){
        return false;
    }

    switch (type){
            
        case "object":
            if( !value || Object.keys(value).length===0){
                return false;
            }
        return true;

        case "boolean":
            if( value===null || typeof value !== 'boolean'){
                return false;
            }
            return true;

        case "array":
            if( !value || !Array.isArray(value)){
                return false;
            }
        return true;

        case "string":
            if( !value || typeof value !== 'string'){
                return false;
            }
        return true;

        case "number":
            if( !value || typeof value !== 'number'){
                return false;
            }
        return true;

        case "email":
            let emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

            if (typeof value !== 'string' || !value.match(emailPattern)){
                return false;
            }
        return true;

        case "password":
            let passwdPattern = /^[A-Za-z]\w{7,19}$/;

            if (typeof value !== 'string' || !value.match(passwdPattern)){
                return false;
            }
        return true;

        case "objectIdArray":
            let objectIdPattern = /^[0-9a-fA-F]{24}$/;
            
            if(!value || !Array.isArray(value)){
                return false;
            }
            console.log(isArrayValid(value,objectIdPattern))
            if(!isArrayValid(value,objectIdPattern)){
                return false;
            }
        return true;
    }
}

function isArrayValid(array,pattern){
    
    for(var i = 0; i<array.length;i++){
        if(!array[i].match(pattern)){
            return false;
        }
    }
    return true;
}