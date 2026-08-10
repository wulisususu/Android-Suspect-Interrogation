.class Lcom/alibaba/sdk/android/push/a/a$3$1;
.super Lcom/taobao/agoo/ICallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/alibaba/sdk/android/push/a/a$3;->onSuccess(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/alibaba/sdk/android/push/a/a$3;


# direct methods
.method constructor <init>(Lcom/alibaba/sdk/android/push/a/a$3;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/push/a/a$3$1;->a:Lcom/alibaba/sdk/android/push/a/a$3;

    invoke-direct {p0}, Lcom/taobao/agoo/ICallback;-><init>()V

    return-void
.end method


# virtual methods
.method public onFailure(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    invoke-static {p1, p2}, Lcom/alibaba/sdk/android/push/common/global/c;->a(Ljava/lang/String;Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object p1

    const-string p2, "turnOnPushChannel bindAgoo"

    invoke-virtual {p1, p2}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->detail(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object p1

    invoke-virtual {p1}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object p1

    iget-object p2, p0, Lcom/alibaba/sdk/android/push/a/a$3$1;->a:Lcom/alibaba/sdk/android/push/a/a$3;

    iget-object p2, p2, Lcom/alibaba/sdk/android/push/a/a$3;->a:Lcom/alibaba/sdk/android/push/CommonCallback;

    if-eqz p2, :cond_0

    iget-object p2, p0, Lcom/alibaba/sdk/android/push/a/a$3$1;->a:Lcom/alibaba/sdk/android/push/a/a$3;

    iget-object p2, p2, Lcom/alibaba/sdk/android/push/a/a$3;->a:Lcom/alibaba/sdk/android/push/CommonCallback;

    invoke-virtual {p1}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCode()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1}, Lcom/alibaba/sdk/android/error/ErrorCode;->getMsg()Ljava/lang/String;

    move-result-object p1

    invoke-interface {p2, v0, p1}, Lcom/alibaba/sdk/android/push/CommonCallback;->onFailed(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method public onSuccess()V
    .locals 2

    invoke-static {}, Lcom/alibaba/sdk/android/push/e/g;->a()Lcom/alibaba/sdk/android/push/e/g;

    move-result-object v0

    new-instance v1, Lcom/alibaba/sdk/android/push/a/a$3$1$1;

    invoke-direct {v1, p0}, Lcom/alibaba/sdk/android/push/a/a$3$1$1;-><init>(Lcom/alibaba/sdk/android/push/a/a$3$1;)V

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/push/e/g;->e(Lcom/alibaba/sdk/android/push/CommonCallback;)V

    return-void
.end method
