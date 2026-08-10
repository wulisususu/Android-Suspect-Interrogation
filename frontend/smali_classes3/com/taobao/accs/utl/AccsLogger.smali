.class public Lcom/taobao/accs/utl/AccsLogger;
.super Ljava/lang/Object;
.source "Taobao"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/accs/utl/AccsLogger$a;
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 8
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static addILogger(Lcom/alibaba/sdk/android/logger/ILogger;)V
    .locals 1

    .line 48
    invoke-static {}, Lcom/taobao/accs/utl/AccsLogger$a;->a()Lcom/alibaba/sdk/android/logger/BaseSdkLogApi;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/alibaba/sdk/android/logger/BaseSdkLogApi;->addILogger(Lcom/alibaba/sdk/android/logger/ILogger;)V

    return-void
.end method

.method public static enable(Z)V
    .locals 1

    .line 19
    invoke-static {}, Lcom/taobao/accs/utl/AccsLogger$a;->a()Lcom/alibaba/sdk/android/logger/BaseSdkLogApi;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/alibaba/sdk/android/logger/BaseSdkLogApi;->enable(Z)V

    return-void
.end method

.method public static getLogger(Ljava/lang/Object;)Lcom/alibaba/sdk/android/logger/ILog;
    .locals 1

    .line 67
    invoke-static {}, Lcom/taobao/accs/utl/AccsLogger$a;->a()Lcom/alibaba/sdk/android/logger/BaseSdkLogApi;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/alibaba/sdk/android/logger/BaseSdkLogApi;->getLogger(Ljava/lang/Object;)Lcom/alibaba/sdk/android/logger/ILog;

    move-result-object p0

    return-object p0
.end method

.method public static removeILogger(Lcom/alibaba/sdk/android/logger/ILogger;)V
    .locals 1

    .line 57
    invoke-static {}, Lcom/taobao/accs/utl/AccsLogger$a;->a()Lcom/alibaba/sdk/android/logger/BaseSdkLogApi;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/alibaba/sdk/android/logger/BaseSdkLogApi;->removeILogger(Lcom/alibaba/sdk/android/logger/ILogger;)V

    return-void
.end method

.method public static setILogger(Lcom/alibaba/sdk/android/logger/ILogger;)V
    .locals 1

    .line 38
    invoke-static {}, Lcom/taobao/accs/utl/AccsLogger$a;->a()Lcom/alibaba/sdk/android/logger/BaseSdkLogApi;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/alibaba/sdk/android/logger/BaseSdkLogApi;->setILogger(Lcom/alibaba/sdk/android/logger/ILogger;)V

    return-void
.end method

.method public static setLevel(Lcom/alibaba/sdk/android/logger/LogLevel;)V
    .locals 1

    .line 28
    invoke-static {}, Lcom/taobao/accs/utl/AccsLogger$a;->a()Lcom/alibaba/sdk/android/logger/BaseSdkLogApi;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/alibaba/sdk/android/logger/BaseSdkLogApi;->setLevel(Lcom/alibaba/sdk/android/logger/LogLevel;)V

    return-void
.end method
