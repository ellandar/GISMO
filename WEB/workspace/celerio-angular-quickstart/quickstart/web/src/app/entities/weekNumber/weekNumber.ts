//
// Source code generated by Celerio, a Jaxio product.
// Documentation: http://www.jaxio.com/documentation/celerio/
// Follow us on twitter: @jaxiosoft
// Need commercial support ? Contact us: info@jaxio.com
// Template pack-angular:web/src/app/entities/entity.ts.e.vm
//

export class WeekNumber {
    // Raw attributes
    id : number;
    dateyear : number;
    dateweek : number;
    dateday : string;
    date : Date;


    constructor(json? : any) {
        if (json != null) {
            this.id = json.id;
            this.dateyear = json.dateyear;
            this.dateweek = json.dateweek;
            this.dateday = json.dateday;
            if (json.date != null) {
                this.date = new Date(json.date);
            }
        }
    }

    // Utils

    static toArray(jsons : any[]) : WeekNumber[] {
        let weekNumbers : WeekNumber[] = [];
        if (jsons != null) {
            for (let json of jsons) {
                weekNumbers.push(new WeekNumber(json));
            }
        }
        return weekNumbers;
    }
}
