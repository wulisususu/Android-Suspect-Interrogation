.class Lcom/taobao/tao/log/godeye/core/control/a$b;
.super Ljava/lang/Object;
.source "GodeyeJointPointCenter.java"

# interfaces
.implements Landroid/app/Application$ActivityLifecycleCallbacks;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/tao/log/godeye/core/control/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "b"
.end annotation


# instance fields
.field final synthetic a:Lcom/taobao/tao/log/godeye/core/control/a;

.field private c:I


# direct methods
.method constructor <init>(Lcom/taobao/tao/log/godeye/core/control/a;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/tao/log/godeye/core/control/a$b;->a:Lcom/taobao/tao/log/godeye/core/control/a;

    .line 212
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 p1, 0x0

    iput p1, p0, Lcom/taobao/tao/log/godeye/core/control/a$b;->c:I

    return-void
.end method


# virtual methods
.method public onActivityCreated(Landroid/app/Activity;Landroid/os/Bundle;)V
    .locals 1

    .line 221
    invoke-static {}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->sharedInstance()Lcom/taobao/tao/log/godeye/core/control/Godeye;

    move-result-object p2

    invoke-virtual {p2}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->isDebugMode()Z

    move-result p2

    if-nez p2, :cond_0

    return-void

    .line 225
    :cond_0
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object p1

    const-string p2, "onActivityCreated"

    invoke-static {p1, p2}, Lcom/taobao/tao/log/godeye/core/control/a;->b(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object p2, p0, Lcom/taobao/tao/log/godeye/core/control/a$b;->a:Lcom/taobao/tao/log/godeye/core/control/a;

    .line 226
    invoke-static {p2}, Lcom/taobao/tao/log/godeye/core/control/a;->a(Lcom/taobao/tao/log/godeye/core/control/a;)Ljava/util/concurrent/ConcurrentHashMap;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/util/List;

    invoke-static {p2, p1}, Lcom/taobao/tao/log/godeye/core/control/a;->a(Lcom/taobao/tao/log/godeye/core/control/a;Ljava/util/List;)V

    return-void
.end method

.method public onActivityDestroyed(Landroid/app/Activity;)V
    .locals 4

    .line 296
    invoke-static {}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->sharedInstance()Lcom/taobao/tao/log/godeye/core/control/Godeye;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->isDebugMode()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    .line 299
    :cond_0
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object p1

    const-string v0, "onActivityDestroyed"

    invoke-static {p1, v0}, Lcom/taobao/tao/log/godeye/core/control/a;->b(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lcom/taobao/tao/log/godeye/core/control/a$b;->a:Lcom/taobao/tao/log/godeye/core/control/a;

    .line 300
    invoke-static {v0}, Lcom/taobao/tao/log/godeye/core/control/a;->a(Lcom/taobao/tao/log/godeye/core/control/a;)Ljava/util/concurrent/ConcurrentHashMap;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/List;

    invoke-static {v0, v1}, Lcom/taobao/tao/log/godeye/core/control/a;->a(Lcom/taobao/tao/log/godeye/core/control/a;Ljava/util/List;)V

    .line 301
    invoke-static {}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->sharedInstance()Lcom/taobao/tao/log/godeye/core/control/Godeye;

    move-result-object v0

    new-instance v1, Lcom/taobao/tao/log/godeye/a/b/a;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    const/4 v3, 0x0

    invoke-direct {v1, v2, p1, v3}, Lcom/taobao/tao/log/godeye/a/b/a;-><init>(Ljava/lang/Long;Ljava/lang/String;Ljava/lang/Object;)V

    invoke-virtual {v0, v1}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->addClientEvent(Lcom/taobao/tao/log/godeye/a/b/a;)V

    return-void
.end method

.method public onActivityPaused(Landroid/app/Activity;)V
    .locals 4

    .line 261
    invoke-static {}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->sharedInstance()Lcom/taobao/tao/log/godeye/core/control/Godeye;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->isDebugMode()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    .line 265
    :cond_0
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object p1

    const-string v0, "onActivityPaused"

    invoke-static {p1, v0}, Lcom/taobao/tao/log/godeye/core/control/a;->b(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lcom/taobao/tao/log/godeye/core/control/a$b;->a:Lcom/taobao/tao/log/godeye/core/control/a;

    .line 266
    invoke-static {v0}, Lcom/taobao/tao/log/godeye/core/control/a;->a(Lcom/taobao/tao/log/godeye/core/control/a;)Ljava/util/concurrent/ConcurrentHashMap;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/List;

    invoke-static {v0, v1}, Lcom/taobao/tao/log/godeye/core/control/a;->a(Lcom/taobao/tao/log/godeye/core/control/a;Ljava/util/List;)V

    .line 267
    invoke-static {}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->sharedInstance()Lcom/taobao/tao/log/godeye/core/control/Godeye;

    move-result-object v0

    new-instance v1, Lcom/taobao/tao/log/godeye/a/b/a;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    const/4 v3, 0x0

    invoke-direct {v1, v2, p1, v3}, Lcom/taobao/tao/log/godeye/a/b/a;-><init>(Ljava/lang/Long;Ljava/lang/String;Ljava/lang/Object;)V

    invoke-virtual {v0, v1}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->addClientEvent(Lcom/taobao/tao/log/godeye/a/b/a;)V

    return-void
.end method

.method public onActivityResumed(Landroid/app/Activity;)V
    .locals 4

    .line 248
    invoke-static {}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->sharedInstance()Lcom/taobao/tao/log/godeye/core/control/Godeye;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->isDebugMode()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    .line 252
    :cond_0
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lcom/taobao/tao/log/godeye/core/control/a$b;->a:Lcom/taobao/tao/log/godeye/core/control/a;

    .line 253
    invoke-static {v0, p1}, Lcom/taobao/tao/log/godeye/core/control/a;->a(Lcom/taobao/tao/log/godeye/core/control/a;Ljava/lang/String;)Ljava/lang/String;

    const-string v0, "onActivityResumed"

    .line 254
    invoke-static {p1, v0}, Lcom/taobao/tao/log/godeye/core/control/a;->b(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lcom/taobao/tao/log/godeye/core/control/a$b;->a:Lcom/taobao/tao/log/godeye/core/control/a;

    .line 255
    invoke-static {v0}, Lcom/taobao/tao/log/godeye/core/control/a;->a(Lcom/taobao/tao/log/godeye/core/control/a;)Ljava/util/concurrent/ConcurrentHashMap;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/List;

    invoke-static {v0, v1}, Lcom/taobao/tao/log/godeye/core/control/a;->a(Lcom/taobao/tao/log/godeye/core/control/a;Ljava/util/List;)V

    .line 256
    invoke-static {}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->sharedInstance()Lcom/taobao/tao/log/godeye/core/control/Godeye;

    move-result-object v0

    new-instance v1, Lcom/taobao/tao/log/godeye/a/b/a;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    const/4 v3, 0x0

    invoke-direct {v1, v2, p1, v3}, Lcom/taobao/tao/log/godeye/a/b/a;-><init>(Ljava/lang/Long;Ljava/lang/String;Ljava/lang/Object;)V

    invoke-virtual {v0, v1}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->addClientEvent(Lcom/taobao/tao/log/godeye/a/b/a;)V

    return-void
.end method

.method public onActivitySaveInstanceState(Landroid/app/Activity;Landroid/os/Bundle;)V
    .locals 1

    .line 287
    invoke-static {}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->sharedInstance()Lcom/taobao/tao/log/godeye/core/control/Godeye;

    move-result-object p2

    invoke-virtual {p2}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->isDebugMode()Z

    move-result p2

    if-nez p2, :cond_0

    return-void

    .line 290
    :cond_0
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object p1

    const-string p2, "onActivitySaveInstanceState"

    invoke-static {p1, p2}, Lcom/taobao/tao/log/godeye/core/control/a;->b(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object p2, p0, Lcom/taobao/tao/log/godeye/core/control/a$b;->a:Lcom/taobao/tao/log/godeye/core/control/a;

    .line 291
    invoke-static {p2}, Lcom/taobao/tao/log/godeye/core/control/a;->a(Lcom/taobao/tao/log/godeye/core/control/a;)Ljava/util/concurrent/ConcurrentHashMap;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/util/List;

    invoke-static {p2, p1}, Lcom/taobao/tao/log/godeye/core/control/a;->a(Lcom/taobao/tao/log/godeye/core/control/a;Ljava/util/List;)V

    return-void
.end method

.method public onActivityStarted(Landroid/app/Activity;)V
    .locals 5

    iget v0, p0, Lcom/taobao/tao/log/godeye/core/control/a$b;->c:I

    const/4 v1, 0x1

    add-int/2addr v0, v1

    iput v0, p0, Lcom/taobao/tao/log/godeye/core/control/a$b;->c:I

    .line 233
    invoke-static {}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->sharedInstance()Lcom/taobao/tao/log/godeye/core/control/Godeye;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->isDebugMode()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    .line 237
    :cond_0
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object p1

    const-string v0, "onActivityStarted"

    invoke-static {p1, v0}, Lcom/taobao/tao/log/godeye/core/control/a;->b(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lcom/taobao/tao/log/godeye/core/control/a$b;->a:Lcom/taobao/tao/log/godeye/core/control/a;

    .line 238
    invoke-static {v0}, Lcom/taobao/tao/log/godeye/core/control/a;->a(Lcom/taobao/tao/log/godeye/core/control/a;)Ljava/util/concurrent/ConcurrentHashMap;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/util/List;

    invoke-static {v0, v2}, Lcom/taobao/tao/log/godeye/core/control/a;->a(Lcom/taobao/tao/log/godeye/core/control/a;Ljava/util/List;)V

    .line 239
    invoke-static {}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->sharedInstance()Lcom/taobao/tao/log/godeye/core/control/Godeye;

    move-result-object v0

    new-instance v2, Lcom/taobao/tao/log/godeye/a/b/a;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v3

    invoke-static {v3, v4}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v3

    const/4 v4, 0x0

    invoke-direct {v2, v3, p1, v4}, Lcom/taobao/tao/log/godeye/a/b/a;-><init>(Ljava/lang/Long;Ljava/lang/String;Ljava/lang/Object;)V

    invoke-virtual {v0, v2}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->addClientEvent(Lcom/taobao/tao/log/godeye/a/b/a;)V

    iget p1, p0, Lcom/taobao/tao/log/godeye/core/control/a$b;->c:I

    if-ne p1, v1, :cond_1

    iget-object p1, p0, Lcom/taobao/tao/log/godeye/core/control/a$b;->a:Lcom/taobao/tao/log/godeye/core/control/a;

    .line 241
    invoke-static {p1}, Lcom/taobao/tao/log/godeye/core/control/a;->a(Lcom/taobao/tao/log/godeye/core/control/a;)Ljava/util/Vector;

    move-result-object v0

    invoke-static {p1, v0}, Lcom/taobao/tao/log/godeye/core/control/a;->a(Lcom/taobao/tao/log/godeye/core/control/a;Ljava/util/List;)V

    .line 242
    invoke-static {}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->sharedInstance()Lcom/taobao/tao/log/godeye/core/control/Godeye;

    move-result-object p1

    new-instance v0, Lcom/taobao/tao/log/godeye/a/b/a;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "enter_foreground"

    invoke-direct {v0, v1, v2, v4}, Lcom/taobao/tao/log/godeye/a/b/a;-><init>(Ljava/lang/Long;Ljava/lang/String;Ljava/lang/Object;)V

    invoke-virtual {p1, v0}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->addClientEvent(Lcom/taobao/tao/log/godeye/a/b/a;)V

    :cond_1
    return-void
.end method

.method public onActivityStopped(Landroid/app/Activity;)V
    .locals 4

    iget v0, p0, Lcom/taobao/tao/log/godeye/core/control/a$b;->c:I

    add-int/lit8 v0, v0, -0x1

    iput v0, p0, Lcom/taobao/tao/log/godeye/core/control/a$b;->c:I

    .line 273
    invoke-static {}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->sharedInstance()Lcom/taobao/tao/log/godeye/core/control/Godeye;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->isDebugMode()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    .line 276
    :cond_0
    invoke-virtual {p1}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object p1

    const-string v0, "onActivityStopped"

    invoke-static {p1, v0}, Lcom/taobao/tao/log/godeye/core/control/a;->b(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iget-object v0, p0, Lcom/taobao/tao/log/godeye/core/control/a$b;->a:Lcom/taobao/tao/log/godeye/core/control/a;

    .line 277
    invoke-static {v0}, Lcom/taobao/tao/log/godeye/core/control/a;->a(Lcom/taobao/tao/log/godeye/core/control/a;)Ljava/util/concurrent/ConcurrentHashMap;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/util/concurrent/ConcurrentHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/List;

    invoke-static {v0, v1}, Lcom/taobao/tao/log/godeye/core/control/a;->a(Lcom/taobao/tao/log/godeye/core/control/a;Ljava/util/List;)V

    .line 278
    invoke-static {}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->sharedInstance()Lcom/taobao/tao/log/godeye/core/control/Godeye;

    move-result-object v0

    new-instance v1, Lcom/taobao/tao/log/godeye/a/b/a;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    const/4 v3, 0x0

    invoke-direct {v1, v2, p1, v3}, Lcom/taobao/tao/log/godeye/a/b/a;-><init>(Ljava/lang/Long;Ljava/lang/String;Ljava/lang/Object;)V

    invoke-virtual {v0, v1}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->addClientEvent(Lcom/taobao/tao/log/godeye/a/b/a;)V

    iget p1, p0, Lcom/taobao/tao/log/godeye/core/control/a$b;->c:I

    if-nez p1, :cond_1

    iget-object p1, p0, Lcom/taobao/tao/log/godeye/core/control/a$b;->a:Lcom/taobao/tao/log/godeye/core/control/a;

    .line 280
    invoke-static {p1}, Lcom/taobao/tao/log/godeye/core/control/a;->b(Lcom/taobao/tao/log/godeye/core/control/a;)Ljava/util/Vector;

    move-result-object v0

    invoke-static {p1, v0}, Lcom/taobao/tao/log/godeye/core/control/a;->a(Lcom/taobao/tao/log/godeye/core/control/a;Ljava/util/List;)V

    .line 281
    invoke-static {}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->sharedInstance()Lcom/taobao/tao/log/godeye/core/control/Godeye;

    move-result-object p1

    new-instance v0, Lcom/taobao/tao/log/godeye/a/b/a;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    invoke-static {v1, v2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v1

    const-string v2, "enter_background"

    invoke-direct {v0, v1, v2, v3}, Lcom/taobao/tao/log/godeye/a/b/a;-><init>(Ljava/lang/Long;Ljava/lang/String;Ljava/lang/Object;)V

    invoke-virtual {p1, v0}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->addClientEvent(Lcom/taobao/tao/log/godeye/a/b/a;)V

    :cond_1
    return-void
.end method
