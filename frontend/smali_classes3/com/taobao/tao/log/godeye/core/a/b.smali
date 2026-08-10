.class public Lcom/taobao/tao/log/godeye/core/a/b;
.super Ljava/lang/Object;
.source "GodeyeRemoteCommandCenter.java"


# instance fields
.field private a:Ljava/util/Set;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Set<",
            "Lcom/taobao/tao/log/godeye/a/a/a$a<",
            "Lcom/taobao/tao/log/godeye/api/b/a;",
            ">;>;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 16
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 18
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    iput-object v0, p0, Lcom/taobao/tao/log/godeye/core/a/b;->a:Ljava/util/Set;

    return-void
.end method


# virtual methods
.method public a()Ljava/util/Set;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Set<",
            "Lcom/taobao/tao/log/godeye/a/a/a$a<",
            "Lcom/taobao/tao/log/godeye/api/b/a;",
            ">;>;"
        }
    .end annotation

    iget-object v0, p0, Lcom/taobao/tao/log/godeye/core/a/b;->a:Ljava/util/Set;

    return-object v0
.end method

.method public a(Lcom/taobao/tao/log/godeye/api/b/a;Lcom/taobao/tao/log/godeye/api/a/e;Z)V
    .locals 7

    if-eqz p1, :cond_2

    if-nez p2, :cond_0

    goto :goto_0

    .line 72
    :cond_0
    iget-object v0, p2, Lcom/taobao/tao/log/godeye/api/a/e;->requestId:Ljava/lang/String;

    iput-object v0, p1, Lcom/taobao/tao/log/godeye/api/b/a;->g:Ljava/lang/String;

    .line 74
    invoke-virtual {p1}, Lcom/taobao/tao/log/godeye/api/b/a;->a()Lcom/taobao/tao/log/godeye/api/a/b;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 76
    invoke-virtual {p1}, Lcom/taobao/tao/log/godeye/api/b/a;->a()Lcom/taobao/tao/log/godeye/api/a/b;

    move-result-object p1

    invoke-interface {p1, p2, p3}, Lcom/taobao/tao/log/godeye/api/a/b;->a(Lcom/taobao/tao/log/godeye/api/a/e;Z)V

    goto :goto_0

    .line 77
    :cond_1
    invoke-virtual {p1}, Lcom/taobao/tao/log/godeye/api/b/a;->a()Lcom/taobao/tao/log/godeye/api/b/c$a;

    move-result-object v0

    if-eqz v0, :cond_2

    .line 78
    invoke-virtual {p1}, Lcom/taobao/tao/log/godeye/api/b/a;->b()Lcom/taobao/tao/log/godeye/api/b/c$a;

    move-result-object v0

    if-eqz v0, :cond_2

    .line 82
    :try_start_0
    invoke-static {}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->sharedInstance()Lcom/taobao/tao/log/godeye/core/control/Godeye;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->defaultCommandManager()Lcom/taobao/tao/log/godeye/api/a/a;

    move-result-object v0

    invoke-interface {v0, p1, p2}, Lcom/taobao/tao/log/godeye/api/a/a;->a(Lcom/taobao/tao/log/godeye/api/b/a;Lcom/taobao/tao/log/godeye/api/a/e;)V

    .line 85
    invoke-static {}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->sharedInstance()Lcom/taobao/tao/log/godeye/core/control/Godeye;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->defaultGodeyeJointPointCenter()Lcom/taobao/tao/log/godeye/core/control/a;

    move-result-object v1

    iget-object v2, p2, Lcom/taobao/tao/log/godeye/api/a/e;->start:Lcom/taobao/android/tlog/protocol/model/joint/point/JointPoint;

    .line 86
    invoke-virtual {p1}, Lcom/taobao/tao/log/godeye/api/b/a;->a()Lcom/taobao/tao/log/godeye/api/b/c$a;

    move-result-object v3

    iget-object v4, p2, Lcom/taobao/tao/log/godeye/api/a/e;->stop:Lcom/taobao/android/tlog/protocol/model/joint/point/JointPoint;

    .line 87
    invoke-virtual {p1}, Lcom/taobao/tao/log/godeye/api/b/a;->b()Lcom/taobao/tao/log/godeye/api/b/c$a;

    move-result-object v5

    move v6, p3

    .line 85
    invoke-virtual/range {v1 .. v6}, Lcom/taobao/tao/log/godeye/core/control/a;->a(Lcom/taobao/android/tlog/protocol/model/joint/point/JointPoint;Lcom/taobao/tao/log/godeye/api/b/c$a;Lcom/taobao/android/tlog/protocol/model/joint/point/JointPoint;Lcom/taobao/tao/log/godeye/api/b/c$a;Z)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    .line 90
    invoke-virtual {p1}, Ljava/lang/Exception;->printStackTrace()V

    :cond_2
    :goto_0
    return-void
.end method

.method public a(Ljava/lang/String;Lcom/taobao/tao/log/godeye/api/b/a;)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/tao/log/godeye/core/a/b;->a:Ljava/util/Set;

    .line 27
    invoke-static {p1, p2}, Lcom/taobao/tao/log/godeye/a/a/a$a;->a(Ljava/lang/String;Ljava/lang/Object;)Lcom/taobao/tao/log/godeye/a/a/a$a;

    move-result-object p1

    invoke-interface {v0, p1}, Ljava/util/Set;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method public b(Lcom/taobao/android/tlog/protocol/model/GodeyeInfo;)V
    .locals 4

    .line 42
    :try_start_0
    invoke-static {}, Lcom/taobao/tao/log/godeye/core/b/a;->c()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .line 44
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    :goto_0
    iget-object v0, p0, Lcom/taobao/tao/log/godeye/core/a/b;->a:Ljava/util/Set;

    .line 47
    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    :goto_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/taobao/tao/log/godeye/a/a/a$a;

    .line 48
    invoke-virtual {v1}, Lcom/taobao/tao/log/godeye/a/a/a$a;->d()Ljava/lang/String;

    move-result-object v2

    iget-object v3, p1, Lcom/taobao/android/tlog/protocol/model/GodeyeInfo;->commandInfo:Lcom/taobao/android/tlog/protocol/model/CommandInfo;

    iget-object v3, v3, Lcom/taobao/android/tlog/protocol/model/CommandInfo;->opCode:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 50
    :try_start_1
    new-instance v2, Lcom/taobao/tao/log/godeye/api/a/e;

    invoke-direct {v2}, Lcom/taobao/tao/log/godeye/api/a/e;-><init>()V

    .line 51
    invoke-virtual {v2, p1}, Lcom/taobao/tao/log/godeye/api/a/e;->a(Lcom/taobao/android/tlog/protocol/model/GodeyeInfo;)V

    .line 52
    invoke-virtual {v1}, Lcom/taobao/tao/log/godeye/a/a/a$a;->getValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/taobao/tao/log/godeye/api/b/a;

    const/4 v3, 0x0

    invoke-virtual {p0, v1, v2, v3}, Lcom/taobao/tao/log/godeye/core/a/b;->a(Lcom/taobao/tao/log/godeye/api/b/a;Lcom/taobao/tao/log/godeye/api/a/e;Z)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_1

    :catch_1
    move-exception v1

    .line 54
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_1

    :cond_1
    return-void
.end method
