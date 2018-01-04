function outer(){
    var data = "closures are ";
    return function inner(){
        //this function capture the outside variable "data"
        var innerData = "awesome";
        return data + innerData;
    }
}

outer()();

/* hide private variable */
function counter(){
    var count = 0;
    return function (){
        return ++count;
    }
}

var countFn = counter();
countFn();
countFn();

function classRoom(){
    var instructors = ['Colt', 'Elie'];
    return {
        getInstructors: function(){
            return instructors;
        },
        addInstructor: function(instructor){
            instructors.push(instructor);
            return instructors;
        }
    }
}

course1 = classRoom();
course1.getInstructors(); //['Colt', 'Elie']
course1.addInstructor("Ian") //[ 'Colt', 'Elie', 'Ian' ]