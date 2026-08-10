.class public interface abstract Lcom/taobao/accs/base/AccsDataListenerV2;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Lcom/taobao/accs/base/AccsDataListener;


# virtual methods
.method public abstract onBind(Ljava/lang/String;ILjava/lang/String;Lcom/taobao/accs/base/TaoBaseService$ExtraInfo;)V
.end method

.method public abstract onResponse(Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;[BLcom/taobao/accs/base/TaoBaseService$ExtraInfo;)V
.end method

.method public abstract onSendData(Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;Lcom/taobao/accs/base/TaoBaseService$ExtraInfo;)V
.end method

.method public abstract onUnbind(Ljava/lang/String;ILjava/lang/String;Lcom/taobao/accs/base/TaoBaseService$ExtraInfo;)V
.end method
