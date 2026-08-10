.class public Lcom/alibaba/sdk/android/push/a/a;
.super Ljava/lang/Object;


# static fields
.field private static final b:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;


# instance fields
.field private final a:Landroid/content/Context;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-string v0, "MPS:CloudPushService"

    invoke-static {v0}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->getLogger(Ljava/lang/String;)Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    move-result-object v0

    sput-object v0, Lcom/alibaba/sdk/android/push/a/a;->b:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/alibaba/sdk/android/push/a/a;->a:Landroid/content/Context;

    invoke-static {p1}, Lcom/alibaba/sdk/android/push/e/g;->a(Landroid/content/Context;)V

    return-void
.end method

.method static synthetic a(Lcom/alibaba/sdk/android/push/a/a;)Landroid/content/Context;
    .locals 0

    iget-object p0, p0, Lcom/alibaba/sdk/android/push/a/a;->a:Landroid/content/Context;

    return-object p0
.end method

.method static synthetic c()Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;
    .locals 1

    sget-object v0, Lcom/alibaba/sdk/android/push/a/a;->b:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    return-object v0
.end method


# virtual methods
.method public a()Ljava/lang/String;
    .locals 1

    invoke-static {}, Lcom/alibaba/sdk/android/ams/common/b/c;->a()Lcom/alibaba/sdk/android/ams/common/b/b;

    move-result-object v0

    invoke-interface {v0}, Lcom/alibaba/sdk/android/ams/common/b/b;->b()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public a(Landroid/content/Context;)Ljava/lang/String;
    .locals 0

    invoke-static {p1}, Lcom/ut/device/UTDevice;->getUtdid(Landroid/content/Context;)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method public a(I)V
    .locals 0

    invoke-static {p1}, Lcom/alibaba/sdk/android/push/common/global/MpsGlobalSetter;->setNotificationSmallIconId(I)V

    return-void
.end method

.method public a(IIIILcom/alibaba/sdk/android/push/CommonCallback;)V
    .locals 4

    sget-object v0, Lcom/alibaba/sdk/android/push/a/a;->b:Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "setDoNotDisturb "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ":"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, "-"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p4}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->d(Ljava/lang/String;)V

    new-instance v0, Lcom/alibaba/sdk/android/push/a/a$1;

    invoke-direct {v0, p0, p5}, Lcom/alibaba/sdk/android/push/a/a$1;-><init>(Lcom/alibaba/sdk/android/push/a/a;Lcom/alibaba/sdk/android/push/CommonCallback;)V

    invoke-static {p1, p2, p3, p4, v0}, Lcom/taobao/agoo/TaobaoRegister;->setDoNotDisturb(IIIILcom/aliyun/ams/emas/push/CommonCallback;)V

    return-void
.end method

.method public a(ILcom/alibaba/sdk/android/push/CommonCallback;)V
    .locals 1

    invoke-static {}, Lcom/alibaba/sdk/android/push/e/g;->a()Lcom/alibaba/sdk/android/push/e/g;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Lcom/alibaba/sdk/android/push/e/g;->a(ILcom/alibaba/sdk/android/push/CommonCallback;)V

    return-void
.end method

.method public a(I[Ljava/lang/String;Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V
    .locals 1

    invoke-static {}, Lcom/alibaba/sdk/android/push/e/g;->a()Lcom/alibaba/sdk/android/push/e/g;

    move-result-object v0

    invoke-virtual {v0, p1, p2, p3, p4}, Lcom/alibaba/sdk/android/push/e/g;->a(I[Ljava/lang/String;Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V

    return-void
.end method

.method public a(Landroid/graphics/Bitmap;)V
    .locals 0

    invoke-static {p1}, Lcom/alibaba/sdk/android/push/common/global/MpsGlobalSetter;->setNotificationLargeIconBitmap(Landroid/graphics/Bitmap;)V

    return-void
.end method

.method public a(Lcom/alibaba/sdk/android/push/CommonCallback;)V
    .locals 1

    invoke-static {}, Lcom/alibaba/sdk/android/push/e/g;->a()Lcom/alibaba/sdk/android/push/e/g;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/push/e/g;->a(Lcom/alibaba/sdk/android/push/CommonCallback;)V

    return-void
.end method

.method public a(Lcom/alibaba/sdk/android/push/notification/CPushMessage;)V
    .locals 0

    invoke-static {p1}, Lcom/alibaba/sdk/android/push/notification/CPushMessage;->to(Lcom/alibaba/sdk/android/push/notification/CPushMessage;)Lcom/aliyun/ams/emas/push/notification/CPushMessage;

    move-result-object p1

    invoke-static {p1}, Lcom/taobao/agoo/TaobaoRegister;->clickMessage(Lcom/aliyun/ams/emas/push/notification/CPushMessage;)V

    return-void
.end method

.method public a(Ljava/lang/Class;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;)V"
        }
    .end annotation

    invoke-static {p1}, Lcom/taobao/agoo/TaobaoRegister;->setPushMsgReceiveService(Ljava/lang/Class;)V

    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 0

    invoke-static {p1}, Lcom/alibaba/sdk/android/push/common/global/MpsGlobalSetter;->setNotificationSoundPath(Ljava/lang/String;)V

    return-void
.end method

.method public a(Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V
    .locals 1

    invoke-static {}, Lcom/alibaba/sdk/android/push/e/g;->a()Lcom/alibaba/sdk/android/push/e/g;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Lcom/alibaba/sdk/android/push/e/g;->a(Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V

    return-void
.end method

.method public a(Z)V
    .locals 0

    invoke-static {p1}, Lcom/taobao/agoo/TaobaoRegister;->setDoNotDisturbMode(Z)V

    return-void
.end method

.method public b()V
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/push/a/a;->a:Landroid/content/Context;

    invoke-static {v0}, Lcom/taobao/agoo/TaobaoRegister;->clearNotificationCreatedByAliyun(Landroid/content/Context;)V

    return-void
.end method

.method public b(I[Ljava/lang/String;Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V
    .locals 1

    invoke-static {}, Lcom/alibaba/sdk/android/push/e/g;->a()Lcom/alibaba/sdk/android/push/e/g;

    move-result-object v0

    invoke-virtual {v0, p1, p2, p3, p4}, Lcom/alibaba/sdk/android/push/e/g;->b(I[Ljava/lang/String;Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V

    return-void
.end method

.method public b(Landroid/content/Context;)V
    .locals 1

    invoke-static {}, Lcom/alibaba/sdk/android/push/e/g;->a()Lcom/alibaba/sdk/android/push/e/g;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/push/e/g;->b(Landroid/content/Context;)V

    return-void
.end method

.method public b(Lcom/alibaba/sdk/android/push/CommonCallback;)V
    .locals 1

    invoke-static {}, Lcom/alibaba/sdk/android/push/e/g;->a()Lcom/alibaba/sdk/android/push/e/g;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/push/e/g;->b(Lcom/alibaba/sdk/android/push/CommonCallback;)V

    return-void
.end method

.method public b(Lcom/alibaba/sdk/android/push/notification/CPushMessage;)V
    .locals 0

    invoke-static {p1}, Lcom/alibaba/sdk/android/push/notification/CPushMessage;->to(Lcom/alibaba/sdk/android/push/notification/CPushMessage;)Lcom/aliyun/ams/emas/push/notification/CPushMessage;

    move-result-object p1

    invoke-static {p1}, Lcom/taobao/agoo/TaobaoRegister;->dismissMessage(Lcom/aliyun/ams/emas/push/notification/CPushMessage;)V

    return-void
.end method

.method public b(Ljava/lang/String;)V
    .locals 1

    invoke-static {}, Lcom/alibaba/sdk/android/ams/common/b/c;->a()Lcom/alibaba/sdk/android/ams/common/b/b;

    move-result-object v0

    invoke-interface {v0, p1}, Lcom/alibaba/sdk/android/ams/common/b/b;->d(Ljava/lang/String;)V

    return-void
.end method

.method public b(Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V
    .locals 1

    invoke-static {}, Lcom/alibaba/sdk/android/push/e/g;->a()Lcom/alibaba/sdk/android/push/e/g;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Lcom/alibaba/sdk/android/push/e/g;->b(Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V

    return-void
.end method

.method public b(Z)V
    .locals 0

    invoke-static {p1}, Lcom/alibaba/sdk/android/push/common/global/MpsGlobalSetter;->setDebug(Z)V

    return-void
.end method

.method public c(Lcom/alibaba/sdk/android/push/CommonCallback;)V
    .locals 1

    invoke-static {}, Lcom/alibaba/sdk/android/push/e/g;->a()Lcom/alibaba/sdk/android/push/e/g;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/push/e/g;->f(Lcom/alibaba/sdk/android/push/CommonCallback;)V

    return-void
.end method

.method public c(Ljava/lang/String;)V
    .locals 1

    invoke-static {}, Lcom/alibaba/sdk/android/ams/common/b/c;->a()Lcom/alibaba/sdk/android/ams/common/b/b;

    move-result-object v0

    invoke-interface {v0, p1}, Lcom/alibaba/sdk/android/ams/common/b/b;->e(Ljava/lang/String;)V

    return-void
.end method

.method public c(Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V
    .locals 1

    invoke-static {}, Lcom/alibaba/sdk/android/push/e/g;->a()Lcom/alibaba/sdk/android/push/e/g;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Lcom/alibaba/sdk/android/push/e/g;->c(Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V

    return-void
.end method

.method public d(Lcom/alibaba/sdk/android/push/CommonCallback;)V
    .locals 1

    new-instance v0, Lcom/alibaba/sdk/android/push/a/a$2;

    invoke-direct {v0, p0, p1}, Lcom/alibaba/sdk/android/push/a/a$2;-><init>(Lcom/alibaba/sdk/android/push/a/a;Lcom/alibaba/sdk/android/push/CommonCallback;)V

    invoke-virtual {p0, v0}, Lcom/alibaba/sdk/android/push/a/a;->f(Lcom/alibaba/sdk/android/push/CommonCallback;)V

    return-void
.end method

.method public d(Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V
    .locals 1

    invoke-static {}, Lcom/alibaba/sdk/android/push/e/g;->a()Lcom/alibaba/sdk/android/push/e/g;

    move-result-object v0

    invoke-virtual {v0, p1, p2}, Lcom/alibaba/sdk/android/push/e/g;->d(Ljava/lang/String;Lcom/alibaba/sdk/android/push/CommonCallback;)V

    return-void
.end method

.method public e(Lcom/alibaba/sdk/android/push/CommonCallback;)V
    .locals 1

    new-instance v0, Lcom/alibaba/sdk/android/push/a/a$3;

    invoke-direct {v0, p0, p1}, Lcom/alibaba/sdk/android/push/a/a$3;-><init>(Lcom/alibaba/sdk/android/push/a/a;Lcom/alibaba/sdk/android/push/CommonCallback;)V

    invoke-virtual {p0, v0}, Lcom/alibaba/sdk/android/push/a/a;->f(Lcom/alibaba/sdk/android/push/CommonCallback;)V

    return-void
.end method

.method public f(Lcom/alibaba/sdk/android/push/CommonCallback;)V
    .locals 1

    invoke-static {}, Lcom/alibaba/sdk/android/push/e/g;->a()Lcom/alibaba/sdk/android/push/e/g;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/push/e/g;->c(Lcom/alibaba/sdk/android/push/CommonCallback;)V

    return-void
.end method
