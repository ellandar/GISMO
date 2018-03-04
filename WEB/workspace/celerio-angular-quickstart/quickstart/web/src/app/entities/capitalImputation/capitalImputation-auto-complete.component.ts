//
// Source code generated by Celerio, a Jaxio product.
// Documentation: http://www.jaxio.com/documentation/celerio/
// Follow us on twitter: @jaxiosoft
// Need commercial support ? Contact us: info@jaxio.com
// Template pack-angular:web/src/app/entities/entity-auto-complete.component.ts.e.vm
//
import {Component, Input, Output, EventEmitter, forwardRef} from '@angular/core';
import {ControlValueAccessor, NG_VALUE_ACCESSOR} from "@angular/forms";
import {AutoCompleteModule} from 'primeng/primeng';
import {MessageService} from '../../service/message.service';
import {CapitalImputation} from './capitalImputation';
import {CapitalImputationService} from './capitalImputation.service';

// Resource: http://almerosteyn.com/2016/04/linkup-custom-control-to-ngcontrol-ngmodel

export const CAPITALIMPUTATION_AUTO_COMPLETE_CONTROL_VALUE_ACCESSOR: any = {
    provide: NG_VALUE_ACCESSOR,
    useExisting: forwardRef(() => CapitalImputationCompleteComponent),
    multi: true
};

@Component({
	template: `
        <p-autoComplete [(ngModel)]="value" [disabled]="disabled" placeholder="Hint: type to search..." field="dateyear" [suggestions]="suggestions" (completeMethod)="complete($event)" (onSelect)="select($event)">
            <ng-template let-capitalImputation pTemplate="item">
                <capitalImputation-line [capitalImputation]="capitalImputation"></capitalImputation-line>
            </ng-template>
        </p-autoComplete>
	`,
	selector: 'capitalImputation-auto-complete',
    providers: [CAPITALIMPUTATION_AUTO_COMPLETE_CONTROL_VALUE_ACCESSOR]
})
export class CapitalImputationCompleteComponent implements ControlValueAccessor {
    @Input() disabled : boolean = false;
    @Input() id : string;
    @Input() name : string;

    //The internal data model
    private _value: CapitalImputation = null;

    public suggestions : CapitalImputation[] = [];

    //Placeholders for the callbacks
    private _onTouchedCallback: () => void = () => {};
    private _onChangeCallback: (_:any) => void = () => {};

    constructor(private capitalImputationService : CapitalImputationService, private messageService : MessageService) {
    }

    @Input()
    get value(): any { return this._value; };

    //set accessor including call the onchange callback
    set value(v: any) {
        if (this._value != null && (v == null || v == "")) {
            this.select(null);
        }
        // nop, see writeValue and select method
    }

    //Set touched on blur
    onTouched(){
        this._onTouchedCallback();
    }

    //From ControlValueAccessor interface
    writeValue(value: any) {
        this._value = <CapitalImputation> value;
    }

    //From ControlValueAccessor interface
    registerOnChange(fn: any) {
        this._onChangeCallback = fn;
    }

    //From ControlValueAccessor interface
    registerOnTouched(fn: any) {
        this._onTouchedCallback = fn;
    }

    //From ControlValueAccessor interface
    setDisabledState(isDisabled: boolean) {
    }

    complete(event:any) {
        this.capitalImputationService.complete(event.query).
            subscribe(
                results => this.suggestions = results,
                error => this.messageService.error(error, 'Error during auto-complete')
            );
    }

    select(v : any) {
        this._value = v;
        this._onChangeCallback(v);
    }
}