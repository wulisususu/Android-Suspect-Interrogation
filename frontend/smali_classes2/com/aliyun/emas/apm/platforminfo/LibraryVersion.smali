.class abstract Lcom/aliyun/emas/apm/platforminfo/LibraryVersion;
.super Ljava/lang/Object;
.source "SourceFile"


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static a(Ljava/lang/String;Ljava/lang/String;)Lcom/aliyun/emas/apm/platforminfo/LibraryVersion;
    .locals 1

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/platforminfo/a;

    invoke-direct {v0, p0, p1}, Lcom/aliyun/emas/apm/platforminfo/a;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    return-object v0
.end method


# virtual methods
.method public abstract getLibraryName()Ljava/lang/String;
    .annotation runtime Ljavax/annotation/Nonnull;
    .end annotation
.end method

.method public abstract getVersion()Ljava/lang/String;
    .annotation runtime Ljavax/annotation/Nonnull;
    .end annotation
.end method
