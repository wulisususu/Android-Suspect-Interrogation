.class public final synthetic Lcom/aliyun/emas/apm/concurrent/b$$ExternalSyntheticLambda7;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Ljava/lang/Runnable;

.field public final synthetic f$1:Lcom/aliyun/emas/apm/concurrent/c$b;


# direct methods
.method public synthetic constructor <init>(Ljava/lang/Runnable;Lcom/aliyun/emas/apm/concurrent/c$b;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/aliyun/emas/apm/concurrent/b$$ExternalSyntheticLambda7;->f$0:Ljava/lang/Runnable;

    iput-object p2, p0, Lcom/aliyun/emas/apm/concurrent/b$$ExternalSyntheticLambda7;->f$1:Lcom/aliyun/emas/apm/concurrent/c$b;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/concurrent/b$$ExternalSyntheticLambda7;->f$0:Ljava/lang/Runnable;

    iget-object v1, p0, Lcom/aliyun/emas/apm/concurrent/b$$ExternalSyntheticLambda7;->f$1:Lcom/aliyun/emas/apm/concurrent/c$b;

    invoke-static {v0, v1}, Lcom/aliyun/emas/apm/concurrent/b;->$r8$lambda$NnHVYar_Du3ufD2PVEZjCsWjH94(Ljava/lang/Runnable;Lcom/aliyun/emas/apm/concurrent/c$b;)V

    return-void
.end method
