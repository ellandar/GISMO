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
import {CapitalItem} from './capitalItem';
import {CapitalItemService} from './capitalItem.service';

@Component({
    moduleId: module.id,
	templateUrl: 'capitalItem-detail.component.html',
	selector: 'capitalItem-detail',
})
export class CapitalItemDetailComponent implements OnInit, OnDestroy {
    capitalItem : CapitalItem;

    private params_subscription: any;


    @Input() sub : boolean = false;
    @Output() onSaveClicked = new EventEmitter<CapitalItem>();
    @Output() onCancelClicked = new EventEmitter();

    constructor(private route: ActivatedRoute, private router: Router, private messageService: MessageService, private capitalItemService: CapitalItemService) {
    }

    ngOnInit() {
        if (this.sub) {
            return;
        }

        this.params_subscription = this.route.params.subscribe(params => {
            let id = params['id'];
            console.log('ngOnInit for capitalItem-detail ' + id);

            if (id === 'new') {
                this.capitalItem = new CapitalItem();
            } else {
                this.capitalItemService.getCapitalItem(id)
                    .subscribe(capitalItem => {
                            this.capitalItem = capitalItem;
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
        this.capitalItemService.update(this.capitalItem).
            subscribe(
                capitalItem => {
                    this.capitalItem = capitalItem;
                    if (this.sub) {
                        this.onSaveClicked.emit(this.capitalItem);
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
