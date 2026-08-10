.class Lcom/taobao/accs/messenger/c;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field final synthetic a:Landroid/content/Intent;

.field final synthetic b:Lcom/taobao/accs/messenger/b;


# direct methods
.method constructor <init>(Lcom/taobao/accs/messenger/b;Landroid/content/Intent;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/accs/messenger/c;->b:Lcom/taobao/accs/messenger/b;

    iput-object p2, p0, Lcom/taobao/accs/messenger/c;->a:Landroid/content/Intent;

    .line 31
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 0

    .line 34
    invoke-static {}, Lcom/taobao/accs/messenger/MessengerService;->a()V

    return-void
.end method
