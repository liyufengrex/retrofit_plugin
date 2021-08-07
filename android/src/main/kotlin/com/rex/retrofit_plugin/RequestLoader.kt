package com.rex.retrofit_plugin

import android.text.TextUtils
import com.google.gson.Gson
import com.rex.retrofit_plugin.net.NetWorkLoader
import com.rex.retrofit_plugin.net.NetworkRepository
import com.rex.retrofit_plugin.net.response.BaseObserver

/**
 * @Description:    网络请求封装
 * @Author:         liyufeng
 * @CreateDate:     2021/8/4 11:22 上午
 */

class RequestLoader {

    private val repositories: HashMap<String, NetworkRepository> = HashMap()


    private fun getRepository(baseUrl: String): NetworkRepository {
        if (repositories[baseUrl] == null) {
            repositories[baseUrl] = NetWorkLoader.getInstance(baseUrl).getRepository()
        }
        return repositories[baseUrl]!!
    }

    fun doRequest(
        method: String,
        baseUrl: String, pathUrl: String,
        headers: Map<String, String>,
        params: Map<String, Any>,
        callback: IRequestResult
    ) {
        val objCallback = object : BaseObserver<String>() {
            override fun _onSuccess(response: String?) {
                response?.let {
                    callback?.onSuccess(it)
                }
            }

            override fun _onError(errorMsg: String?) {
                super._onError(errorMsg)
                errorMsg?.let {
                    callback?.onError(it)
                }
            }
        }
        if (TextUtils.equals(method, "Post")) {
            getRepository(baseUrl).doPost(pathUrl, headers, params, objCallback)
        } else {
            getRepository(baseUrl).doGet(pathUrl, headers, params, objCallback)
        }
    }
}

interface IRequestResult {
    fun onSuccess(data: String)
    fun onError(msg: String)
}

