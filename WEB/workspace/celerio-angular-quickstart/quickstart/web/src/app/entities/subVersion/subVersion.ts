//
// Source code generated by Celerio, a Jaxio product.
// Documentation: http://www.jaxio.com/documentation/celerio/
// Follow us on twitter: @jaxiosoft
// Need commercial support ? Contact us: info@jaxio.com
// Template pack-angular:web/src/app/entities/entity.ts.e.vm
//

export class SubVersion {
    // Raw attributes
    id : number;
    name : string;
    subProjectId : number;
    versionId : number;


    constructor(json? : any) {
        if (json != null) {
            this.id = json.id;
            this.name = json.name;
            this.subProjectId = json.subProjectId;
            this.versionId = json.versionId;
        }
    }

    // Utils

    static toArray(jsons : any[]) : SubVersion[] {
        let subVersions : SubVersion[] = [];
        if (jsons != null) {
            for (let json of jsons) {
                subVersions.push(new SubVersion(json));
            }
        }
        return subVersions;
    }
}