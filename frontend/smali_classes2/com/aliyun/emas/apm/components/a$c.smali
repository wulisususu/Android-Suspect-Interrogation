.class public Lcom/aliyun/emas/apm/components/a$c;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/aliyun/emas/apm/components/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "c"
.end annotation


# instance fields
.field public final a:Lcom/aliyun/emas/apm/components/Qualified;

.field public final b:Z


# direct methods
.method public constructor <init>(Lcom/aliyun/emas/apm/components/Qualified;Z)V
    .locals 0

    .line 2
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/aliyun/emas/apm/components/a$c;->a:Lcom/aliyun/emas/apm/components/Qualified;

    iput-boolean p2, p0, Lcom/aliyun/emas/apm/components/a$c;->b:Z

    return-void
.end method

.method public synthetic constructor <init>(Lcom/aliyun/emas/apm/components/Qualified;ZLcom/aliyun/emas/apm/components/a$a;)V
    .locals 0

    .line 1
    invoke-direct {p0, p1, p2}, Lcom/aliyun/emas/apm/components/a$c;-><init>(Lcom/aliyun/emas/apm/components/Qualified;Z)V

    return-void
.end method

.method public static synthetic a(Lcom/aliyun/emas/apm/components/a$c;)Z
    .locals 0

    .line 1
    iget-boolean p0, p0, Lcom/aliyun/emas/apm/components/a$c;->b:Z

    return p0
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 3

    .line 1
    instance-of v0, p1, Lcom/aliyun/emas/apm/components/a$c;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    .line 2
    check-cast p1, Lcom/aliyun/emas/apm/components/a$c;

    .line 3
    iget-object v0, p1, Lcom/aliyun/emas/apm/components/a$c;->a:Lcom/aliyun/emas/apm/components/Qualified;

    iget-object v2, p0, Lcom/aliyun/emas/apm/components/a$c;->a:Lcom/aliyun/emas/apm/components/Qualified;

    invoke-virtual {v0, v2}, Lcom/aliyun/emas/apm/components/Qualified;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-boolean p1, p1, Lcom/aliyun/emas/apm/components/a$c;->b:Z

    iget-boolean v0, p0, Lcom/aliyun/emas/apm/components/a$c;->b:Z

    if-ne p1, v0, :cond_0

    const/4 v1, 0x1

    :cond_0
    return v1
.end method

.method public hashCode()I
    .locals 2

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/a$c;->a:Lcom/aliyun/emas/apm/components/Qualified;

    .line 1
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/components/Qualified;->hashCode()I

    move-result v0

    const v1, 0xf4243

    xor-int/2addr v0, v1

    mul-int/2addr v0, v1

    iget-boolean v1, p0, Lcom/aliyun/emas/apm/components/a$c;->b:Z

    .line 3
    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Boolean;->hashCode()I

    move-result v1

    xor-int/2addr v0, v1

    return v0
.end method
