.class public Lcom/alibaba/sdk/android/push/e/h;
.super Lcom/alibaba/sdk/android/push/common/util/a/c;


# static fields
.field private static final c:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;


# instance fields
.field private final d:Lcom/alibaba/sdk/android/push/CommonCallback;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-string v0, "MPS:VipRequestTask"

    invoke-static {v0}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->getLogger(Ljava/lang/String;)Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    move-result-object v0

    sput-object v0, Lcom/alibaba/sdk/android/push/e/h;->c:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lcom/alibaba/sdk/android/push/common/util/a/c;-><init>(Landroid/content/Context;Ljava/lang/String;)V

    iput-object p3, p0, Lcom/alibaba/sdk/android/push/e/h;->d:Lcom/alibaba/sdk/android/push/CommonCallback;

    return-void
.end method

.method private a(ILcom/alibaba/sdk/android/push/common/util/a/b;Lcom/alibaba/sdk/android/push/CommonCallback;)V
    .locals 3

    if-nez p3, :cond_0

    return-void

    :cond_0
    sget-object v0, Lcom/alibaba/sdk/android/push/e/h;->c:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "requestType: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", errorCode:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p2, Lcom/alibaba/sdk/android/push/common/util/a/b;->c:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", httpcode: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget v2, p2, Lcom/alibaba/sdk/android/push/common/util/a/b;->b:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", content:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p2, Lcom/alibaba/sdk/android/push/common/util/a/b;->a:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->d(Ljava/lang/String;)V

    iget-object v0, p2, Lcom/alibaba/sdk/android/push/common/util/a/b;->c:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCode()Ljava/lang/String;

    move-result-object v0

    sget-object v1, Lcom/alibaba/sdk/android/push/common/global/c;->a:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {v1}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCode()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_1

    iget-object p1, p2, Lcom/alibaba/sdk/android/push/common/util/a/b;->c:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {p1}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCode()Ljava/lang/String;

    move-result-object p1

    iget-object p2, p2, Lcom/alibaba/sdk/android/push/common/util/a/b;->c:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/error/ErrorCode;->getMsg()Ljava/lang/String;

    move-result-object p2

    invoke-interface {p3, p1, p2}, Lcom/alibaba/sdk/android/push/CommonCallback;->onFailed(Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :cond_1
    iget v0, p2, Lcom/alibaba/sdk/android/push/common/util/a/b;->b:I

    iget-object p2, p2, Lcom/alibaba/sdk/android/push/common/util/a/b;->a:Ljava/lang/String;

    :try_start_0
    invoke-static {p1, v0, p2}, Lcom/alibaba/sdk/android/push/e/i;->a(IILjava/lang/String;)Ljava/lang/String;

    move-result-object p1

    invoke-interface {p3, p1}, Lcom/alibaba/sdk/android/push/CommonCallback;->onSuccess(Ljava/lang/String;)V
    :try_end_0
    .catch Lcom/alibaba/sdk/android/push/a/f; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_1

    :catchall_0
    move-exception p1

    sget-object p2, Lcom/alibaba/sdk/android/push/e/h;->c:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    const-string v0, "Vip call failed."

    invoke-virtual {p2, v0, p1}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    sget-object p2, Lcom/alibaba/sdk/android/push/common/global/c;->k:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/error/ErrorCode;->copy()Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object p2

    invoke-virtual {p1}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p2, v0}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object p2

    invoke-static {p1}, Landroid/util/Log;->getStackTraceString(Ljava/lang/Throwable;)Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->detail(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object p1

    invoke-virtual {p1}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object p1

    invoke-virtual {p1}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCode()Ljava/lang/String;

    move-result-object p2

    goto :goto_0

    :catch_0
    move-exception p1

    sget-object p2, Lcom/alibaba/sdk/android/push/e/h;->c:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    const-string v0, "Vip call failed"

    invoke-virtual {p2, v0, p1}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    invoke-virtual {p1}, Lcom/alibaba/sdk/android/push/a/f;->a()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object p2

    invoke-virtual {p2}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCode()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p1}, Lcom/alibaba/sdk/android/push/a/f;->a()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object p1

    :goto_0
    invoke-virtual {p1}, Lcom/alibaba/sdk/android/error/ErrorCode;->getMsg()Ljava/lang/String;

    move-result-object p1

    invoke-interface {p3, p2, p1}, Lcom/alibaba/sdk/android/push/CommonCallback;->onFailed(Ljava/lang/String;Ljava/lang/String;)V

    :goto_1
    return-void
.end method


# virtual methods
.method protected a(Landroid/content/Context;Ljava/util/Map;)Ljava/util/Map;
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    invoke-static {p2}, Lcom/alibaba/sdk/android/ams/common/util/c;->a(Ljava/util/Map;)Ljava/util/Map;

    move-result-object p1

    return-object p1
.end method

.method protected a(Lcom/alibaba/sdk/android/push/common/util/a/b;)V
    .locals 2

    invoke-super {p0, p1}, Lcom/alibaba/sdk/android/push/common/util/a/c;->a(Lcom/alibaba/sdk/android/push/common/util/a/b;)V

    invoke-virtual {p0}, Lcom/alibaba/sdk/android/push/e/h;->a()I

    move-result v0

    iget-object v1, p0, Lcom/alibaba/sdk/android/push/e/h;->d:Lcom/alibaba/sdk/android/push/CommonCallback;

    invoke-direct {p0, v0, p1, v1}, Lcom/alibaba/sdk/android/push/e/h;->a(ILcom/alibaba/sdk/android/push/common/util/a/b;Lcom/alibaba/sdk/android/push/CommonCallback;)V

    return-void
.end method

.method protected synthetic onPostExecute(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Lcom/alibaba/sdk/android/push/common/util/a/b;

    invoke-virtual {p0, p1}, Lcom/alibaba/sdk/android/push/e/h;->a(Lcom/alibaba/sdk/android/push/common/util/a/b;)V

    return-void
.end method
