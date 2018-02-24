//
// Source code generated by Celerio, a Jaxio product.
// Documentation: http://www.jaxio.com/documentation/celerio/
// Follow us on twitter: @jaxiosoft
// Need commercial support ? Contact us: info@jaxio.com
// Template pack-angular:web/src/app/entities/entity.ts.e.vm
//

export class JiraTask {
    // Raw attributes
    id : number;
    projectname : string;
    ident : string;
    issuetype : string;
    summary : string;
    severity : string;
    status : string;
    priority : string;
    assignee : string;
    reporter : string;
    components : string;
    linkedissue : string;
    affversion : string;
    targetversion : string;
    deliveryversion : string;
    projectId : number;
    versionId : number;
    subProjectId : number;
    subVersionId : number;
    taskTypeId : number;
    taskId : number;
    state : string;
    warning : string;
    error : string;


    constructor(json? : any) {
        if (json != null) {
            this.id = json.id;
            this.projectname = json.projectname;
            this.ident = json.ident;
            this.issuetype = json.issuetype;
            this.summary = json.summary;
            this.severity = json.severity;
            this.status = json.status;
            this.priority = json.priority;
            this.assignee = json.assignee;
            this.reporter = json.reporter;
            this.components = json.components;
            this.linkedissue = json.linkedissue;
            this.affversion = json.affversion;
            this.targetversion = json.targetversion;
            this.deliveryversion = json.deliveryversion;
            this.projectId = json.projectId;
            this.versionId = json.versionId;
            this.subProjectId = json.subProjectId;
            this.subVersionId = json.subVersionId;
            this.taskTypeId = json.taskTypeId;
            this.taskId = json.taskId;
            this.state = json.state;
            this.warning = json.warning;
            this.error = json.error;
        }
    }

    // Utils

    static toArray(jsons : any[]) : JiraTask[] {
        let jiraTasks : JiraTask[] = [];
        if (jsons != null) {
            for (let json of jsons) {
                jiraTasks.push(new JiraTask(json));
            }
        }
        return jiraTasks;
    }
}
