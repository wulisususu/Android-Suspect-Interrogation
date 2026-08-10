.class Lanet/channel/a;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field final synthetic a:Landroid/content/Intent;

.field final synthetic b:Lanet/channel/AccsSessionManager;


# direct methods
.method constructor <init>(Lanet/channel/AccsSessionManager;Landroid/content/Intent;)V
    .locals 0

    iput-object p1, p0, Lanet/channel/a;->b:Lanet/channel/AccsSessionManager;

    iput-object p2, p0, Lanet/channel/a;->a:Landroid/content/Intent;

    .line 115
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 6

    .line 118
    invoke-static {}, Lanet/channel/AccsSessionManager;->a()Ljava/util/concurrent/CopyOnWriteArraySet;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/concurrent/CopyOnWriteArraySet;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lanet/channel/ISessionListener;

    :try_start_0
    iget-object v2, p0, Lanet/channel/a;->a:Landroid/content/Intent;

    .line 120
    invoke-interface {v1, v2}, Lanet/channel/ISessionListener;->onConnectionChanged(Landroid/content/Intent;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v1

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    const-string v3, "awcn.AccsSessionManager"

    const-string v4, "notifyListener exception."

    const/4 v5, 0x0

    .line 122
    invoke-static {v3, v4, v5, v1, v2}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    goto :goto_0

    :cond_0
    return-void
.end method
