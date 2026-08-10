.class Lcom/alibaba/sdk/android/push/a/a$3$1$1$1;
.super Lcom/taobao/agoo/ICallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/alibaba/sdk/android/push/a/a$3$1$1;->onFailed(Ljava/lang/String;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Ljava/lang/String;

.field final synthetic c:Lcom/alibaba/sdk/android/push/a/a$3$1$1;


# direct methods
.method constructor <init>(Lcom/alibaba/sdk/android/push/a/a$3$1$1;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/push/a/a$3$1$1$1;->c:Lcom/alibaba/sdk/android/push/a/a$3$1$1;

    iput-object p2, p0, Lcom/alibaba/sdk/android/push/a/a$3$1$1$1;->a:Ljava/lang/String;

    iput-object p3, p0, Lcom/alibaba/sdk/android/push/a/a$3$1$1$1;->b:Ljava/lang/String;

    invoke-direct {p0}, Lcom/taobao/agoo/ICallback;-><init>()V

    return-void
.end method


# virtual methods
.method public onFailure(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    invoke-static {p1, p2}, Lcom/alibaba/sdk/android/push/common/global/c;->a(Ljava/lang/String;Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object p1

    const-string p2, "turnOnPushChannel unbindAgoo"

    invoke-virtual {p1, p2}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->detail(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object p1

    invoke-virtual {p1}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object p1

    iget-object p2, p0, Lcom/alibaba/sdk/android/push/a/a$3$1$1$1;->c:Lcom/alibaba/sdk/android/push/a/a$3$1$1;

    iget-object p2, p2, Lcom/alibaba/sdk/android/push/a/a$3$1$1;->a:Lcom/alibaba/sdk/android/push/a/a$3$1;

    iget-object p2, p2, Lcom/alibaba/sdk/android/push/a/a$3$1;->a:Lcom/alibaba/sdk/android/push/a/a$3;

    iget-object p2, p2, Lcom/alibaba/sdk/android/push/a/a$3;->a:Lcom/alibaba/sdk/android/push/CommonCallback;

    if-eqz p2, :cond_0

    iget-object p2, p0, Lcom/alibaba/sdk/android/push/a/a$3$1$1$1;->c:Lcom/alibaba/sdk/android/push/a/a$3$1$1;

    iget-object p2, p2, Lcom/alibaba/sdk/android/push/a/a$3$1$1;->a:Lcom/alibaba/sdk/android/push/a/a$3$1;

    iget-object p2, p2, Lcom/alibaba/sdk/android/push/a/a$3$1;->a:Lcom/alibaba/sdk/android/push/a/a$3;

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
    .locals 3

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/a/a$3$1$1$1;->c:Lcom/alibaba/sdk/android/push/a/a$3$1$1;

    iget-object v0, v0, Lcom/alibaba/sdk/android/push/a/a$3$1$1;->a:Lcom/alibaba/sdk/android/push/a/a$3$1;

    iget-object v0, v0, Lcom/alibaba/sdk/android/push/a/a$3$1;->a:Lcom/alibaba/sdk/android/push/a/a$3;

    iget-object v0, v0, Lcom/alibaba/sdk/android/push/a/a$3;->a:Lcom/alibaba/sdk/android/push/CommonCallback;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/a/a$3$1$1$1;->c:Lcom/alibaba/sdk/android/push/a/a$3$1$1;

    iget-object v0, v0, Lcom/alibaba/sdk/android/push/a/a$3$1$1;->a:Lcom/alibaba/sdk/android/push/a/a$3$1;

    iget-object v0, v0, Lcom/alibaba/sdk/android/push/a/a$3$1;->a:Lcom/alibaba/sdk/android/push/a/a$3;

    iget-object v0, v0, Lcom/alibaba/sdk/android/push/a/a$3;->a:Lcom/alibaba/sdk/android/push/CommonCallback;

    iget-object v1, p0, Lcom/alibaba/sdk/android/push/a/a$3$1$1$1;->a:Ljava/lang/String;

    iget-object v2, p0, Lcom/alibaba/sdk/android/push/a/a$3$1$1$1;->b:Ljava/lang/String;

    invoke-interface {v0, v1, v2}, Lcom/alibaba/sdk/android/push/CommonCallback;->onFailed(Ljava/lang/String;Ljava/lang/String;)V

    :cond_0
    return-void
.end method
