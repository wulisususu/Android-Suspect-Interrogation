.class public final synthetic Lcom/aliyun/emas/apm/concurrent/b$$ExternalSyntheticLambda1;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Ljava/util/concurrent/Callable;

.field public final synthetic f$1:Lcom/aliyun/emas/apm/concurrent/c$b;


# direct methods
.method public synthetic constructor <init>(Ljava/util/concurrent/Callable;Lcom/aliyun/emas/apm/concurrent/c$b;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/aliyun/emas/apm/concurrent/b$$ExternalSyntheticLambda1;->f$0:Ljava/util/concurrent/Callable;

    iput-object p2, p0, Lcom/aliyun/emas/apm/concurrent/b$$ExternalSyntheticLambda1;->f$1:Lcom/aliyun/emas/apm/concurrent/c$b;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/concurrent/b$$ExternalSyntheticLambda1;->f$0:Ljava/util/concurrent/Callable;

    iget-object v1, p0, Lcom/aliyun/emas/apm/concurrent/b$$ExternalSyntheticLambda1;->f$1:Lcom/aliyun/emas/apm/concurrent/c$b;

    invoke-static {v0, v1}, Lcom/aliyun/emas/apm/concurrent/b;->$r8$lambda$qX2xryk_3sht6-_f0C7JppOziGY(Ljava/util/concurrent/Callable;Lcom/aliyun/emas/apm/concurrent/c$b;)V

    return-void
.end method
