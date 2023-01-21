namespace GENERIC_1{
    interface Person{ 
        name: string;
    }
    interface Taxes {
        year: number
    }
    
    interface Container<T> {unit: T;}
    
    let personContainer: Container<Person> = {unit: {name: "steve"}};

}
