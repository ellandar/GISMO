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
import {SubVersion} from './subVersion';
import {SubVersionService} from './subVersion.service';

@Component({
    moduleId: module.id,
	templateUrl: 'subVersion-detail.component.html',
	selector: 'subVersion-detail',
})
export class SubVersionDetailComponent implements OnInit, OnDestroy {
    subVersion : SubVersion;

    private params_subscription: any;


    @Input() sub : boolean = false;
    @Output() onSaveClicked = new EventEmitter<SubVersion>();
    @Output() onCancelClicked = new EventEmitter();

    constructor(private route: ActivatedRoute, private router: Router, private messageService: MessageService, private subVersionService: SubVersionService) {
    }

    ngOnInit() {
        if (this.sub) {
            return;
        }

        this.params_subscription = this.route.params.subscribe(params => {
            let id = params['id'];
            console.log('ngOnInit for subVersion-detail ' + id);

            if (id === 'new') {
                this.subVersion = new SubVersion();
            } else {
                this.subVersionService.getSubVersion(id)
                    .subscribe(subVersion => {
                            this.subVersion = subVersion;
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
        this.subVersionService.update(this.subVersion).
            subscribe(
                subVersion => {
                    this.subVersion = subVersion;
                    if (this.sub) {
                        this.onSaveClicked.emit(this.subVersion);
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
