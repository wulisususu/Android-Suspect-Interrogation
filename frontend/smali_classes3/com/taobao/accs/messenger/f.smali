.class Lcom/taobao/accs/messenger/f;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Landroid/content/Intent;

.field final synthetic c:Lcom/taobao/accs/messenger/e;


# direct methods
.method constructor <init>(Lcom/taobao/accs/messenger/e;Ljava/lang/String;Landroid/content/Intent;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/accs/messenger/f;->c:Lcom/taobao/accs/messenger/e;

    iput-object p2, p0, Lcom/taobao/accs/messenger/f;->a:Ljava/lang/String;

    iput-object p3, p0, Lcom/taobao/accs/messenger/f;->b:Landroid/content/Intent;

    .line 60
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    iget-object v0, p0, Lcom/taobao/accs/messenger/f;->c:Lcom/taobao/accs/messenger/e;

    iget-object v1, p0, Lcom/taobao/accs/messenger/f;->a:Ljava/lang/String;

    iget-object v2, p0, Lcom/taobao/accs/messenger/f;->b:Landroid/content/Intent;

    .line 63
    invoke-static {v0, v1, v2}, Lcom/taobao/accs/messenger/e;->a(Lcom/taobao/accs/messenger/e;Ljava/lang/String;Landroid/content/Intent;)V

    return-void
.end method
