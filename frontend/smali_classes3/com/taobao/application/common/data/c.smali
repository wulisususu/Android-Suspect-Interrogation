.class public Lcom/taobao/application/common/data/c;
.super Lcom/taobao/application/common/data/a;
.source "AppLaunchHelper.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/application/common/data/c$a;
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 1
    invoke-direct {p0}, Lcom/taobao/application/common/data/a;-><init>()V

    return-void
.end method


# virtual methods
.method public a(J)V
    .locals 2

    .line 1
    iget-object v0, p0, Lcom/taobao/application/common/data/a;->preferences:Lcom/taobao/application/common/impl/AppPreferencesImpl;

    const-string v1, "lastStartProcessTime"

    invoke-virtual {v0, v1, p1, p2}, Lcom/taobao/application/common/impl/AppPreferencesImpl;->putLong(Ljava/lang/String;J)V

    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 2

    .line 3
    iget-object v0, p0, Lcom/taobao/application/common/data/a;->preferences:Lcom/taobao/application/common/impl/AppPreferencesImpl;

    const-string v1, "launchType"

    invoke-virtual {v0, v1, p1}, Lcom/taobao/application/common/impl/AppPreferencesImpl;->putString(Ljava/lang/String;Ljava/lang/String;)V

    return-void
.end method

.method public a(Z)V
    .locals 2

    .line 2
    iget-object v0, p0, Lcom/taobao/application/common/data/a;->preferences:Lcom/taobao/application/common/impl/AppPreferencesImpl;

    const-string v1, "isFirstLaunch"

    invoke-virtual {v0, v1, p1}, Lcom/taobao/application/common/impl/AppPreferencesImpl;->putBoolean(Ljava/lang/String;Z)V

    return-void
.end method

.method public b(J)V
    .locals 2

    .line 1
    iget-object v0, p0, Lcom/taobao/application/common/data/a;->preferences:Lcom/taobao/application/common/impl/AppPreferencesImpl;

    const-string v1, "startAppOnCreateSystemClockTime"

    invoke-virtual {v0, v1, p1, p2}, Lcom/taobao/application/common/impl/AppPreferencesImpl;->putLong(Ljava/lang/String;J)V

    return-void
.end method

.method public b(Z)V
    .locals 2

    .line 2
    iget-object v0, p0, Lcom/taobao/application/common/data/a;->preferences:Lcom/taobao/application/common/impl/AppPreferencesImpl;

    const-string v1, "isFullNewInstall"

    invoke-virtual {v0, v1, p1}, Lcom/taobao/application/common/impl/AppPreferencesImpl;->putBoolean(Ljava/lang/String;Z)V

    return-void
.end method

.method public c(J)V
    .locals 2

    .line 1
    iget-object v0, p0, Lcom/taobao/application/common/data/a;->preferences:Lcom/taobao/application/common/impl/AppPreferencesImpl;

    const-string v1, "startAppOnCreateSystemTime"

    invoke-virtual {v0, v1, p1, p2}, Lcom/taobao/application/common/impl/AppPreferencesImpl;->putLong(Ljava/lang/String;J)V

    return-void
.end method

.method public d(J)V
    .locals 2

    .line 1
    iget-object v0, p0, Lcom/taobao/application/common/data/a;->preferences:Lcom/taobao/application/common/impl/AppPreferencesImpl;

    const-string v1, "startProcessSystemClockTime"

    invoke-virtual {v0, v1, p1, p2}, Lcom/taobao/application/common/impl/AppPreferencesImpl;->putLong(Ljava/lang/String;J)V

    return-void
.end method

.method public e(J)V
    .locals 2

    .line 1
    iget-object v0, p0, Lcom/taobao/application/common/data/a;->preferences:Lcom/taobao/application/common/impl/AppPreferencesImpl;

    const-string v1, "startProcessSystemTime"

    invoke-virtual {v0, v1, p1, p2}, Lcom/taobao/application/common/impl/AppPreferencesImpl;->putLong(Ljava/lang/String;J)V

    .line 2
    invoke-static {p1, p2}, Lcom/taobao/application/common/data/c$a;->a(J)V

    return-void
.end method
