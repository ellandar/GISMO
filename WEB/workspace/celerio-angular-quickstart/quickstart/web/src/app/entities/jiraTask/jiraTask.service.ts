//
// Source code generated by Celerio, a Jaxio product.
// Documentation: http://www.jaxio.com/documentation/celerio/
// Follow us on twitter: @jaxiosoft
// Need commercial support ? Contact us: info@jaxio.com
// Template pack-angular:web/src/app/entities/entity.service.ts.e.vm
//
import { Injectable } from '@angular/core';
import { HttpClient, HttpResponse, HttpErrorResponse } from '@angular/common/http';
import { LazyLoadEvent } from 'primeng/primeng';
import { MessageService } from '../../service/message.service';
import { PageResponse, PageRequestByExample } from '../../support/paging';
import { JiraTask } from './jiraTask';
import { Observable } from 'rxjs/Rx';
import { catchError, map } from 'rxjs/operators';
import 'rxjs/add/observable/throw';

@Injectable()
export class JiraTaskService {

    constructor(private http: HttpClient, private messageService : MessageService) {}

    /**
     * Get a JiraTask by id.
     */
    getJiraTask(id : any) : Observable<JiraTask> {
        return this.http.get('/api/jiraTasks/' + id)
            .pipe(
                map(response => new JiraTask(response)),
                catchError(this.handleError)
            );
    }

    /**
     * Update the passed jiraTask.
     */
    update(jiraTask : JiraTask) : Observable<JiraTask> {
        let body = jiraTask;

        return this.http.put('/api/jiraTasks/', body)
            .pipe(
                map(response => new JiraTask(response)),
                catchError(this.handleError)
            );
    }

    /**
     * Load a page (for paginated datatable) of JiraTask using the passed
     * jiraTask as an example for the search by example facility.
     */
    getPage(jiraTask : JiraTask, event : LazyLoadEvent) : Observable<PageResponse<JiraTask>> {
        let req = new PageRequestByExample(jiraTask, event);
        let body = req;

        return this.http.post<PageResponse<any>>('/api/jiraTasks/page', body)
            .pipe(
                map(pr =>  new PageResponse<JiraTask>(pr.totalPages, pr.totalElements, JiraTask.toArray(pr.content))),
                catchError(this.handleError)
            );
    }

    /**
     * Performs a search by example on 1 attribute (defined on server side) and returns at most 10 results.
     * Used by JiraTaskCompleteComponent.
     */
    complete(query : string) : Observable<JiraTask[]> {
        let body = {'query': query, 'maxResults': 10};
        return this.http.post<any[]>('/api/jiraTasks/complete', body)
            .pipe(
                map(response => JiraTask.toArray(response)),
                catchError(this.handleError)
            );
    }

    /**
     * Delete an JiraTask by id.
     */
    delete(id : any) {
        return this.http.delete('/api/jiraTasks/' + id)
            .pipe(catchError(this.handleError));
    }

    // sample method from angular doc
    private handleError (error: HttpErrorResponse) {
        // TODO: seems we cannot use messageService from here...
        let errMsg = (error.message) ? error.message : 'Server error';
        console.error(errMsg);
        if (error.status === 401 ) {
            window.location.href = '/';
        }
        return Observable.throw(errMsg);
    }
}
