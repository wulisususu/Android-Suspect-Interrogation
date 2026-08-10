.class Lcom/taobao/accs/internal/c;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field final synthetic a:Landroid/app/job/JobParameters;

.field final synthetic b:Lcom/taobao/accs/internal/AccsJobService;


# direct methods
.method constructor <init>(Lcom/taobao/accs/internal/AccsJobService;Landroid/app/job/JobParameters;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/accs/internal/c;->b:Lcom/taobao/accs/internal/AccsJobService;

    iput-object p2, p0, Lcom/taobao/accs/internal/c;->a:Landroid/app/job/JobParameters;

    .line 42
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    iget-object v0, p0, Lcom/taobao/accs/internal/c;->b:Lcom/taobao/accs/internal/AccsJobService;

    iget-object v1, p0, Lcom/taobao/accs/internal/c;->a:Landroid/app/job/JobParameters;

    const/4 v2, 0x0

    .line 45
    invoke-virtual {v0, v1, v2}, Lcom/taobao/accs/internal/AccsJobService;->jobFinished(Landroid/app/job/JobParameters;Z)V

    return-void
.end method
