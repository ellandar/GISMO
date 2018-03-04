//
// Source code generated by Celerio, a Jaxio product.
// Documentation: http://www.jaxio.com/documentation/celerio/
// Follow us on twitter: @jaxiosoft
// Need commercial support ? Contact us: info@jaxio.com
// Template pack-angular:web/src/app/entities/entity-line.component.ts.e.vm
//
import {Component, Input} from '@angular/core';
import {JiraTask} from './jiraTask';

@Component({
	template: `
        {{ jiraTask?.projectname }} {{ jiraTask?.ident }} {{ jiraTask?.issuetype }} 	`,
	selector: 'jiraTask-line',
})
export class JiraTaskLineComponent {
    @Input() jiraTask : JiraTask;
}