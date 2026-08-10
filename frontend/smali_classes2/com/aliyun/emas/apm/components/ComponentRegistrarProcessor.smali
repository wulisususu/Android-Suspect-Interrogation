.class public interface abstract Lcom/aliyun/emas/apm/components/ComponentRegistrarProcessor;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field public static final NOOP:Lcom/aliyun/emas/apm/components/ComponentRegistrarProcessor;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/components/ComponentRegistrarProcessor$$ExternalSyntheticLambda0;

    invoke-direct {v0}, Lcom/aliyun/emas/apm/components/ComponentRegistrarProcessor$$ExternalSyntheticLambda0;-><init>()V

    sput-object v0, Lcom/aliyun/emas/apm/components/ComponentRegistrarProcessor;->NOOP:Lcom/aliyun/emas/apm/components/ComponentRegistrarProcessor;

    return-void
.end method


# virtual methods
.method public abstract processRegistrar(Lcom/aliyun/emas/apm/components/ComponentRegistrar;)Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/aliyun/emas/apm/components/ComponentRegistrar;",
            ")",
            "Ljava/util/List<",
            "Lcom/aliyun/emas/apm/components/Component<",
            "*>;>;"
        }
    .end annotation
.end method
