//
// Source code generated by Celerio, a Jaxio product.
// Documentation: http://www.jaxio.com/documentation/celerio/
// Follow us on twitter: @jaxiosoft
// Need commercial support ? Contact us: info@jaxio.com
// Template pack-angular:web/src/app/entities/compositepk.ts.cpk.vm
//

export class TaskLinkPk {
    childTaskId : number;
    parentTaskId : number;

    constructor(json? : any) {
        if (json != null) {
            this.childTaskId = json.childTaskId;
            this.parentTaskId = json.parentTaskId;
        }
    }
}