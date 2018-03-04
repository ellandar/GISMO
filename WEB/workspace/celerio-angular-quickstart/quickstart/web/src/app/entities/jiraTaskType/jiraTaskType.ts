//
// Source code generated by Celerio, a Jaxio product.
// Documentation: http://www.jaxio.com/documentation/celerio/
// Follow us on twitter: @jaxiosoft
// Need commercial support ? Contact us: info@jaxio.com
// Template pack-angular:web/src/app/entities/entity.ts.e.vm
//

export class JiraTaskType {
    // Raw attributes
    id : number;
    issuetype : string;
    myComponent : string;
    taskTypeId : number;


    constructor(json? : any) {
        if (json != null) {
            this.id = json.id;
            this.issuetype = json.issuetype;
            this.myComponent = json.myComponent;
            this.taskTypeId = json.taskTypeId;
        }
    }

    // Utils

    static toArray(jsons : any[]) : JiraTaskType[] {
        let jiraTaskTypes : JiraTaskType[] = [];
        if (jsons != null) {
            for (let json of jsons) {
                jiraTaskTypes.push(new JiraTaskType(json));
            }
        }
        return jiraTaskTypes;
    }
}