package com.rex.retrofit_plugin.net

import com.rex.retrofit_plugin.net.base.RetrofitTool
import com.rex.retrofit_plugin.net.response.BaseObserver
import io.reactivex.Observable
import io.reactivex.android.schedulers.AndroidSchedulers
import io.reactivex.schedulers.Schedulers
import retrofit2.http.*

/**
 * @Description:    描述
 * @Author:         liyufeng
 * @CreateDate:     2021/8/4 10:29 上午
 */

interface RepositoryApi {

    companion object {
        fun getInstance(baseUrl: String): RepositoryApi {
            return RetrofitTool.getInstance().createServer(baseUrl, RepositoryApi::class.java)
        }
    }

    @POST
    fun doPost(
        @Url url: String,
        @HeaderMap headers: Map<String, String>,
        @Body params: Map<String, @JvmSuppressWildcards Any>
    ): Observable<String>

    @GET
    fun doGet(
        @Url url: String,
        @HeaderMap headers: Map<String, String>,
        @QueryMap(encoded=false) params: Map<String, @JvmSuppressWildcards Any>
    ): Observable<String>

}

class NetworkRepository(private val api: RepositoryApi) {

    fun doPost(
        url: String,
        headers: Map<String, String>,
        params: Map<String, Any>, observer: BaseObserver<String>
    ) {
        api.doPost(url, headers, params)
            .observeOn(AndroidSchedulers.mainThread())
            .subscribeOn(Schedulers.io())
            .unsubscribeOn(Schedulers.io())
            .subscribe(observer)
    }


    fun doGet(
        url: String,
        headers: Map<String, String>,
        params: Map<String, Any>, observer: BaseObserver<String>
    ) {
        api.doGet(url, headers, params)
            .observeOn(AndroidSchedulers.mainThread())
            .subscribeOn(Schedulers.io())
            .unsubscribeOn(Schedulers.io())
            .subscribe(observer)
    }
}

