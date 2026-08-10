.class Lcom/alibaba/sdk/android/push/e/a$a$2;
.super Lcom/taobao/agoo/IRegister;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/alibaba/sdk/android/push/e/a$a;->b(Landroid/content/Context;)Lcom/alibaba/sdk/android/push/e/e;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:[Lcom/alibaba/sdk/android/push/e/e;

.field final synthetic b:Lcom/alibaba/sdk/android/push/util/c;

.field final synthetic c:Lcom/alibaba/sdk/android/push/e/a$a;


# direct methods
.method constructor <init>(Lcom/alibaba/sdk/android/push/e/a$a;[Lcom/alibaba/sdk/android/push/e/e;Lcom/alibaba/sdk/android/push/util/c;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/push/e/a$a$2;->c:Lcom/alibaba/sdk/android/push/e/a$a;

    iput-object p2, p0, Lcom/alibaba/sdk/android/push/e/a$a$2;->a:[Lcom/alibaba/sdk/android/push/e/e;

    iput-object p3, p0, Lcom/alibaba/sdk/android/push/e/a$a$2;->b:Lcom/alibaba/sdk/android/push/util/c;

    invoke-direct {p0}, Lcom/taobao/agoo/IRegister;-><init>()V

    return-void
.end method


# virtual methods
.method public onFailure(Ljava/lang/String;Ljava/lang/String;)V
    .locals 3

    invoke-static {}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->getImportantLogger()Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "agoo errorcode:"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ";errorMsg:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->i(Ljava/lang/String;)V

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/e/a$a$2;->a:[Lcom/alibaba/sdk/android/push/e/e;

    new-instance v1, Lcom/alibaba/sdk/android/push/e/e;

    invoke-static {p1, p2}, Lcom/alibaba/sdk/android/push/common/global/c;->a(Ljava/lang/String;Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object p1

    const-string p2, "register"

    invoke-virtual {p1, p2}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->detail(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object p1

    invoke-virtual {p1}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object p1

    invoke-direct {v1, p1}, Lcom/alibaba/sdk/android/push/e/e;-><init>(Lcom/alibaba/sdk/android/error/ErrorCode;)V

    const/4 p1, 0x0

    aput-object v1, v0, p1

    iget-object p1, p0, Lcom/alibaba/sdk/android/push/e/a$a$2;->b:Lcom/alibaba/sdk/android/push/util/c;

    invoke-virtual {p1}, Lcom/alibaba/sdk/android/push/util/c;->a()V

    return-void
.end method

.method public onSuccess(Ljava/lang/String;)V
    .locals 2

    invoke-static {}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->getImportantLogger()Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    move-result-object p1

    const-string v0, "agoo init success."

    invoke-virtual {p1, v0}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->i(Ljava/lang/String;)V

    iget-object p1, p0, Lcom/alibaba/sdk/android/push/e/a$a$2;->c:Lcom/alibaba/sdk/android/push/e/a$a;

    const/4 v0, 0x2

    iput v0, p1, Lcom/alibaba/sdk/android/push/e/a$a;->e:I

    iget-object p1, p0, Lcom/alibaba/sdk/android/push/e/a$a$2;->a:[Lcom/alibaba/sdk/android/push/e/e;

    new-instance v0, Lcom/alibaba/sdk/android/push/e/e;

    sget-object v1, Lcom/alibaba/sdk/android/push/common/global/c;->a:Lcom/alibaba/sdk/android/error/ErrorCode;

    invoke-direct {v0, v1}, Lcom/alibaba/sdk/android/push/e/e;-><init>(Lcom/alibaba/sdk/android/error/ErrorCode;)V

    const/4 v1, 0x0

    aput-object v0, p1, v1

    iget-object p1, p0, Lcom/alibaba/sdk/android/push/e/a$a$2;->b:Lcom/alibaba/sdk/android/push/util/c;

    invoke-virtual {p1}, Lcom/alibaba/sdk/android/push/util/c;->a()V

    return-void
.end method
