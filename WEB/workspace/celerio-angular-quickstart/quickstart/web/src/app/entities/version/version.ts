//
// Source code generated by Celerio, a Jaxio product.
// Documentation: http://www.jaxio.com/documentation/celerio/
// Follow us on twitter: @jaxiosoft
// Need commercial support ? Contact us: info@jaxio.com
// Template pack-angular:web/src/app/entities/entity.ts.e.vm
//

export class Version {
    // Raw attributes
    id : number;
    name : string;
    projectId : number;


    constructor(json? : any) {
        if (json != null) {
            this.id = json.id;
            this.name = json.name;
            this.projectId = json.projectId;
        }
    }

    // Utils

    static toArray(jsons : any[]) : Version[] {
        let versions : Version[] = [];
        if (jsons != null) {
            for (let json of jsons) {
                versions.push(new Version(json));
            }
        }
        return versions;
    }
}