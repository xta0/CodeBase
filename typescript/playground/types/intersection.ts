type Admin = {
    name: String;
    privileges: string[];
};

type Employee = {
    name: String;
    startDate: Date;
}

// combine two types
type ElevatedEmployee = Admin & Employee

const e1: ElevatedEmployee = {
    name: 'Max',
    privileges: ['abc'],
    startDate: new Date
};
