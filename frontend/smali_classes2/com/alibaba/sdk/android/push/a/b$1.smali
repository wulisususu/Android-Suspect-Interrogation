.class Lcom/alibaba/sdk/android/push/a/b$1;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/alibaba/sdk/android/crashdefend/CrashDefendCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/alibaba/sdk/android/push/a/b;->a(Landroid/content/Context;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/alibaba/sdk/android/push/a/b;


# direct methods
.method constructor <init>(Lcom/alibaba/sdk/android/push/a/b;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/push/a/b$1;->a:Lcom/alibaba/sdk/android/push/a/b;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onSdkClosed(I)V
    .locals 1

    invoke-static {}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->getImportantLogger()Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    move-result-object p1

    const-string v0, "crash limit exceeds, close forever"

    invoke-virtual {p1, v0}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->e(Ljava/lang/String;)V

    iget-object p1, p0, Lcom/alibaba/sdk/android/push/a/b$1;->a:Lcom/alibaba/sdk/android/push/a/b;

    const/4 v0, 0x0

    invoke-static {p1, v0}, Lcom/alibaba/sdk/android/push/a/b;->a(Lcom/alibaba/sdk/android/push/a/b;Z)Z

    return-void
.end method

.method public onSdkStart(III)V
    .locals 0

    iget-object p1, p0, Lcom/alibaba/sdk/android/push/a/b$1;->a:Lcom/alibaba/sdk/android/push/a/b;

    const/4 p2, 0x1

    invoke-static {p1, p2}, Lcom/alibaba/sdk/android/push/a/b;->a(Lcom/alibaba/sdk/android/push/a/b;Z)Z

    return-void
.end method

.method public onSdkStop(IIIJ)V
    .locals 0

    invoke-static {}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->getImportantLogger()Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;

    move-result-object p1

    const-string p2, "crash limit exceeds"

    invoke-virtual {p1, p2}, Lcom/alibaba/sdk/android/ams/common/logger/AmsLogger;->e(Ljava/lang/String;)V

    iget-object p1, p0, Lcom/alibaba/sdk/android/push/a/b$1;->a:Lcom/alibaba/sdk/android/push/a/b;

    const/4 p2, 0x0

    invoke-static {p1, p2}, Lcom/alibaba/sdk/android/push/a/b;->a(Lcom/alibaba/sdk/android/push/a/b;Z)Z

    return-void
.end method
