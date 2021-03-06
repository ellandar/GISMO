//
// Source code generated by Celerio, a Jaxio product.
// Documentation: http://www.jaxio.com/documentation/celerio/
// Follow us on twitter: @jaxiosoft
// Need commercial support ? Contact us: info@jaxio.com
// Template pack-angular:web/src/app/entities/entity.ts.e.vm
//

export class TaskType {
    // Raw attributes
    id : number;
    name : string;
    type : string;
    projectId : number;
    defaultTaskId : number;


    constructor(json? : any) {
        if (json != null) {
            this.id = json.id;
            this.name = json.name;
            this.type = json.type;
            this.projectId = json.projectId;
            this.defaultTaskId = json.defaultTaskId;
        }
    }

    // Utils

    static toArray(jsons : any[]) : TaskType[] {
        let taskTypes : TaskType[] = [];
        if (jsons != null) {
            for (let json of jsons) {
                taskTypes.push(new TaskType(json));
            }
        }
        return taskTypes;
    }
}
