.class Lcom/alibaba/sdk/android/networkmonitor/b$b;
.super Ljava/lang/Object;
.source "NetworkMonitorManagerImpl.java"

# interfaces
.implements Lcom/alibaba/ha/protocol/lifecycle/LifecycleObserver;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/alibaba/sdk/android/networkmonitor/b;->init(Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/alibaba/sdk/android/networkmonitor/b;


# direct methods
.method constructor <init>(Lcom/alibaba/sdk/android/networkmonitor/b;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/networkmonitor/b$b;->a:Lcom/alibaba/sdk/android/networkmonitor/b;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onBackground(Landroid/app/Activity;)V
    .locals 3

    iget-object p1, p0, Lcom/alibaba/sdk/android/networkmonitor/b$b;->a:Lcom/alibaba/sdk/android/networkmonitor/b;

    .line 1
    invoke-static {p1}, Lcom/alibaba/sdk/android/networkmonitor/b;->a(Lcom/alibaba/sdk/android/networkmonitor/b;)Ljava/util/List;

    move-result-object p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/alibaba/sdk/android/networkmonitor/b$b;->a:Lcom/alibaba/sdk/android/networkmonitor/b;

    invoke-static {p1}, Lcom/alibaba/sdk/android/networkmonitor/b;->a(Lcom/alibaba/sdk/android/networkmonitor/b;)Ljava/util/List;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/List;->isEmpty()Z

    move-result p1

    if-nez p1, :cond_0

    .line 2
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    iget-object p1, p0, Lcom/alibaba/sdk/android/networkmonitor/b$b;->a:Lcom/alibaba/sdk/android/networkmonitor/b;

    .line 3
    invoke-static {p1}, Lcom/alibaba/sdk/android/networkmonitor/b;->a(Lcom/alibaba/sdk/android/networkmonitor/b;)Ljava/util/List;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/alibaba/sdk/android/networkmonitor/utils/a;

    .line 4
    invoke-interface {v2, v0, v1}, Lcom/alibaba/sdk/android/networkmonitor/utils/a;->b(J)V

    goto :goto_0

    :cond_0
    return-void
.end method

.method public onForeground(Landroid/app/Activity;)V
    .locals 3

    .line 1
    invoke-static {}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->getInstance()Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;

    move-result-object p1

    invoke-virtual {p1}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->getActiveActivityCount()I

    move-result p1

    const/4 v0, 0x1

    if-ne p1, v0, :cond_0

    .line 2
    invoke-static {}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->getInstance()Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;

    move-result-object p1

    invoke-virtual {p1}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;->getTotalActivityCount()I

    move-result p1

    if-eq p1, v0, :cond_0

    iget-object p1, p0, Lcom/alibaba/sdk/android/networkmonitor/b$b;->a:Lcom/alibaba/sdk/android/networkmonitor/b;

    .line 4
    invoke-static {p1}, Lcom/alibaba/sdk/android/networkmonitor/b;->a(Lcom/alibaba/sdk/android/networkmonitor/b;)Ljava/util/List;

    move-result-object p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/alibaba/sdk/android/networkmonitor/b$b;->a:Lcom/alibaba/sdk/android/networkmonitor/b;

    invoke-static {p1}, Lcom/alibaba/sdk/android/networkmonitor/b;->a(Lcom/alibaba/sdk/android/networkmonitor/b;)Ljava/util/List;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/List;->isEmpty()Z

    move-result p1

    if-nez p1, :cond_0

    .line 5
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    iget-object p1, p0, Lcom/alibaba/sdk/android/networkmonitor/b$b;->a:Lcom/alibaba/sdk/android/networkmonitor/b;

    .line 6
    invoke-static {p1}, Lcom/alibaba/sdk/android/networkmonitor/b;->a(Lcom/alibaba/sdk/android/networkmonitor/b;)Ljava/util/List;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/alibaba/sdk/android/networkmonitor/utils/a;

    .line 7
    invoke-interface {v2, v0, v1}, Lcom/alibaba/sdk/android/networkmonitor/utils/a;->a(J)V

    goto :goto_0

    :cond_0
    return-void
.end method
