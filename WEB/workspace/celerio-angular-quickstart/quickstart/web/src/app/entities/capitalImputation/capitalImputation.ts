//
// Source code generated by Celerio, a Jaxio product.
// Documentation: http://www.jaxio.com/documentation/celerio/
// Follow us on twitter: @jaxiosoft
// Need commercial support ? Contact us: info@jaxio.com
// Template pack-angular:web/src/app/entities/entity.ts.e.vm
//

export class CapitalImputation {
    // Raw attributes
    id : number;
    dateyear : string;
    dateweek : string;
    dateday : string;
    username : string;
    osname : string;
    timeconsume : number;
    subtype : string;
    osident : string;
    item : string;
    complement : string;
    comment : string;
    phase : string;
    weekid : number;
    userId : number;
    capitalosid : number;
    projectId : number;
    subProjectId : number;
    tasktypeid : number;
    taskid : number;
    warning : string;
    error : string;


    constructor(json? : any) {
        if (json != null) {
            this.id = json.id;
            this.dateyear = json.dateyear;
            this.dateweek = json.dateweek;
            this.dateday = json.dateday;
            this.username = json.username;
            this.osname = json.osname;
            this.timeconsume = json.timeconsume;
            this.subtype = json.subtype;
            this.osident = json.osident;
            this.item = json.item;
            this.complement = json.complement;
            this.comment = json.comment;
            this.phase = json.phase;
            this.weekid = json.weekid;
            this.userId = json.userId;
            this.capitalosid = json.capitalosid;
            this.projectId = json.projectId;
            this.subProjectId = json.subProjectId;
            this.tasktypeid = json.tasktypeid;
            this.taskid = json.taskid;
            this.warning = json.warning;
            this.error = json.error;
        }
    }

    // Utils

    static toArray(jsons : any[]) : CapitalImputation[] {
        let capitalImputations : CapitalImputation[] = [];
        if (jsons != null) {
            for (let json of jsons) {
                capitalImputations.push(new CapitalImputation(json));
            }
        }
        return capitalImputations;
    }
}
