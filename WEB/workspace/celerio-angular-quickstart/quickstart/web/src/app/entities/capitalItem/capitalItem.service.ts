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
import { CapitalItem } from './capitalItem';
import { Observable } from 'rxjs/Rx';
import { catchError, map } from 'rxjs/operators';
import 'rxjs/add/observable/throw';

@Injectable()
export class CapitalItemService {

    constructor(private http: HttpClient, private messageService : MessageService) {}

    /**
     * Get a CapitalItem by id.
     */
    getCapitalItem(id : any) : Observable<CapitalItem> {
        return this.http.get('/api/capitalItems/' + id)
            .pipe(
                map(response => new CapitalItem(response)),
                catchError(this.handleError)
            );
    }

    /**
     * Update the passed capitalItem.
     */
    update(capitalItem : CapitalItem) : Observable<CapitalItem> {
        let body = capitalItem;

        return this.http.put('/api/capitalItems/', body)
            .pipe(
                map(response => new CapitalItem(response)),
                catchError(this.handleError)
            );
    }

    /**
     * Load a page (for paginated datatable) of CapitalItem using the passed
     * capitalItem as an example for the search by example facility.
     */
    getPage(capitalItem : CapitalItem, event : LazyLoadEvent) : Observable<PageResponse<CapitalItem>> {
        let req = new PageRequestByExample(capitalItem, event);
        let body = req;

        return this.http.post<PageResponse<any>>('/api/capitalItems/page', body)
            .pipe(
                map(pr =>  new PageResponse<CapitalItem>(pr.totalPages, pr.totalElements, CapitalItem.toArray(pr.content))),
                catchError(this.handleError)
            );
    }

    /**
     * Performs a search by example on 1 attribute (defined on server side) and returns at most 10 results.
     * Used by CapitalItemCompleteComponent.
     */
    complete(query : string) : Observable<CapitalItem[]> {
        let body = {'query': query, 'maxResults': 10};
        return this.http.post<any[]>('/api/capitalItems/complete', body)
            .pipe(
                map(response => CapitalItem.toArray(response)),
                catchError(this.handleError)
            );
    }

    /**
     * Delete an CapitalItem by id.
     */
    delete(id : any) {
        return this.http.delete('/api/capitalItems/' + id)
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
