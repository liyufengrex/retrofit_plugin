package com.rex.retrofit_plugin.net.response;

import io.reactivex.Observer;
import io.reactivex.disposables.Disposable;

public abstract class BaseObserver<T> implements Observer<T> {

    @Override
    public void onSubscribe(Disposable d) {
        _onSubscribe(d);
    }

    @Override
    public void onNext(T o) {
        if (o != null) {
            _onSuccess(o);
        } else {
            _onError("response is null");
        }
    }

    @Override
    public void onError(Throwable e) {
        _onError(e.getMessage());
    }

    @Override
    public void onComplete() {
        _onComplete();
    }

    protected void _onSubscribe(Disposable d) {
    }

    protected abstract void _onSuccess(T t);

    protected void _onError(String errorMsg) {
    }

    protected void _onComplete() {
    }

}
