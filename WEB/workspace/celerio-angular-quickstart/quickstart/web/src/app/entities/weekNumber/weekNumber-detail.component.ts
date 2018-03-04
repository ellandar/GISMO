//
// Source code generated by Celerio, a Jaxio product.
// Documentation: http://www.jaxio.com/documentation/celerio/
// Follow us on twitter: @jaxiosoft
// Need commercial support ? Contact us: info@jaxio.com
// Template pack-angular:web/src/app/entities/entity-detail.component.ts.e.vm
//
import {Component, OnInit, OnDestroy, Input, Output, EventEmitter} from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { SelectItem } from 'primeng/primeng';
import { MessageService} from '../../service/message.service';
import {WeekNumber} from './weekNumber';
import {WeekNumberService} from './weekNumber.service';

@Component({
    moduleId: module.id,
	templateUrl: 'weekNumber-detail.component.html',
	selector: 'weekNumber-detail',
})
export class WeekNumberDetailComponent implements OnInit, OnDestroy {
    weekNumber : WeekNumber;

    private params_subscription: any;


    @Input() sub : boolean = false;
    @Output() onSaveClicked = new EventEmitter<WeekNumber>();
    @Output() onCancelClicked = new EventEmitter();
    datedayOptions: SelectItem[];

    constructor(private route: ActivatedRoute, private router: Router, private messageService: MessageService, private weekNumberService: WeekNumberService) {
        this.datedayOptions = [];
        this.datedayOptions.push({"label": "Lundi", 'value': "Monday"});
        this.datedayOptions.push({"label": "Mardi", 'value': "Tuesday"});
        this.datedayOptions.push({"label": "Mercredi", 'value': "Wednesday"});
        this.datedayOptions.push({"label": "Jeudi", 'value': "Thursday"});
        this.datedayOptions.push({"label": "Vendredi", 'value': "Friday"});
        this.datedayOptions.push({"label": "Samedi", 'value': "Saturday"});
        this.datedayOptions.push({"label": "Dimanche", 'value': "Sunday"});
    }

    ngOnInit() {
        if (this.sub) {
            return;
        }

        this.params_subscription = this.route.params.subscribe(params => {
            let id = params['id'];
            console.log('ngOnInit for weekNumber-detail ' + id);

            if (id === 'new') {
                this.weekNumber = new WeekNumber();
            } else {
                this.weekNumberService.getWeekNumber(id)
                    .subscribe(weekNumber => {
                            this.weekNumber = weekNumber;
                        },
                        error =>  this.messageService.error('ngOnInit error', error)
                    );
            }
        });
    }

    ngOnDestroy() {
        if (!this.sub) {
            this.params_subscription.unsubscribe();
        }
    }

    onSave() {
        this.weekNumberService.update(this.weekNumber).
            subscribe(
                weekNumber => {
                    this.weekNumber = weekNumber;
                    if (this.sub) {
                        this.onSaveClicked.emit(this.weekNumber);
                        this.messageService.info('Saved OK and msg emitted', 'Angular Rocks!')
                    } else {
                        this.messageService.info('Saved OK', 'Angular Rocks!')
                    }
                },
                error =>  this.messageService.error('Could not save', error)
            );
    }

    onCancel() {
        if (this.sub) {
            this.onCancelClicked.emit("cancel");
            this.messageService.info('Cancel clicked and msg emitted', 'Angular Rocks!')
        }
    }

}