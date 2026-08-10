.class public Lcom/taobao/accs/messenger/a;
.super Ljava/lang/Object;
.source "Taobao"


# instance fields
.field private final a:Landroid/content/Context;

.field private final b:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap<",
            "Ljava/lang/String;",
            "Lcom/taobao/accs/messenger/d;",
            ">;"
        }
    .end annotation
.end field

.field private c:Z


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    .line 23
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 19
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/taobao/accs/messenger/a;->b:Ljava/util/HashMap;

    iput-object p1, p0, Lcom/taobao/accs/messenger/a;->a:Landroid/content/Context;

    return-void
.end method

.method private static a(Landroid/content/Intent;)Landroid/content/Intent;
    .locals 1

    .line 86
    invoke-virtual {p0}, Landroid/content/Intent;->clone()Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Landroid/content/Intent;

    .line 87
    new-instance v0, Landroid/os/Bundle;

    invoke-direct {v0}, Landroid/os/Bundle;-><init>()V

    invoke-virtual {p0, v0}, Landroid/content/Intent;->replaceExtras(Landroid/os/Bundle;)Landroid/content/Intent;

    return-object p0
.end method


# virtual methods
.method public a(Ljava/lang/String;)Lcom/taobao/accs/messenger/d;
    .locals 1

    iget-object v0, p0, Lcom/taobao/accs/messenger/a;->b:Ljava/util/HashMap;

    .line 28
    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/taobao/accs/messenger/d;

    if-eqz p1, :cond_0

    .line 29
    invoke-virtual {p1}, Lcom/taobao/accs/messenger/d;->a()Z

    move-result v0

    if-eqz v0, :cond_0

    return-object p1

    :cond_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public a(Ljava/lang/String;Landroid/content/Intent;)V
    .locals 3

    iget-object v0, p0, Lcom/taobao/accs/messenger/a;->b:Ljava/util/HashMap;

    .line 57
    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/accs/messenger/d;

    if-eqz v0, :cond_2

    .line 60
    invoke-virtual {v0}, Lcom/taobao/accs/messenger/d;->b()Z

    move-result v1

    const/4 v2, 0x0

    if-eqz v1, :cond_1

    .line 61
    invoke-virtual {v0}, Lcom/taobao/accs/messenger/d;->c()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 63
    invoke-virtual {p0, p1, v0}, Lcom/taobao/accs/messenger/a;->a(Ljava/lang/String;Lcom/taobao/accs/messenger/d;)V

    goto :goto_0

    :cond_0
    return-void

    :cond_1
    iget-object v0, p0, Lcom/taobao/accs/messenger/a;->b:Ljava/util/HashMap;

    .line 71
    invoke-virtual {v0, p1}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    :goto_0
    move-object v0, v2

    :cond_2
    if-nez v0, :cond_3

    .line 77
    new-instance v0, Lcom/taobao/accs/messenger/d;

    iget-object v1, p0, Lcom/taobao/accs/messenger/a;->a:Landroid/content/Context;

    invoke-direct {v0, v1, p1, p0}, Lcom/taobao/accs/messenger/d;-><init>(Landroid/content/Context;Ljava/lang/String;Lcom/taobao/accs/messenger/a;)V

    iget-object v1, p0, Lcom/taobao/accs/messenger/a;->b:Ljava/util/HashMap;

    .line 78
    invoke-virtual {v1, p1, v0}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 79
    invoke-static {p2}, Lcom/taobao/accs/messenger/a;->a(Landroid/content/Intent;)Landroid/content/Intent;

    move-result-object p1

    iget-object p2, p0, Lcom/taobao/accs/messenger/a;->a:Landroid/content/Context;

    const/4 v1, 0x1

    .line 80
    invoke-virtual {p2, p1, v0, v1}, Landroid/content/Context;->bindService(Landroid/content/Intent;Landroid/content/ServiceConnection;I)Z

    move-result p1

    iput-boolean p1, p0, Lcom/taobao/accs/messenger/a;->c:Z

    :cond_3
    return-void
.end method

.method public a(Ljava/lang/String;Lcom/taobao/accs/messenger/d;)V
    .locals 1

    .line 43
    invoke-virtual {p0, p1, p2}, Lcom/taobao/accs/messenger/a;->b(Ljava/lang/String;Lcom/taobao/accs/messenger/d;)V

    iget-boolean p1, p0, Lcom/taobao/accs/messenger/a;->c:Z

    if-eqz p1, :cond_0

    :try_start_0
    iget-object p1, p0, Lcom/taobao/accs/messenger/a;->a:Landroid/content/Context;

    .line 46
    invoke-virtual {p1, p2}, Landroid/content/Context;->unbindService(Landroid/content/ServiceConnection;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    .line 48
    new-instance p2, Ljava/lang/StringBuilder;

    const-string v0, "disconnect error: "

    invoke-direct {p2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const/4 p2, 0x0

    new-array p2, p2, [Ljava/lang/Object;

    const-string v0, "ConnectionManager"

    invoke-static {v0, p1, p2}, Lcom/taobao/accs/utl/ALog;->e(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_0
    :goto_0
    return-void
.end method

.method public b(Ljava/lang/String;Lcom/taobao/accs/messenger/d;)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/accs/messenger/a;->b:Ljava/util/HashMap;

    .line 96
    invoke-virtual {v0, p1, p2}, Ljava/util/HashMap;->remove(Ljava/lang/Object;Ljava/lang/Object;)Z

    return-void
.end method
