.class public final Lcom/aliyun/emas/apm/components/Dependency;
.super Ljava/lang/Object;
.source "SourceFile"


# instance fields
.field public final a:Lcom/aliyun/emas/apm/components/Qualified;

.field public final b:I

.field public final c:I


# direct methods
.method public constructor <init>(Lcom/aliyun/emas/apm/components/Qualified;II)V
    .locals 1

    .line 2
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "Null dependency anInterface."

    .line 3
    invoke-static {p1, v0}, Lcom/aliyun/emas/apm/components/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/aliyun/emas/apm/components/Qualified;

    iput-object p1, p0, Lcom/aliyun/emas/apm/components/Dependency;->a:Lcom/aliyun/emas/apm/components/Qualified;

    iput p2, p0, Lcom/aliyun/emas/apm/components/Dependency;->b:I

    iput p3, p0, Lcom/aliyun/emas/apm/components/Dependency;->c:I

    return-void
.end method

.method public constructor <init>(Ljava/lang/Class;II)V
    .locals 0

    .line 1
    invoke-static {p1}, Lcom/aliyun/emas/apm/components/Qualified;->unqualified(Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Qualified;

    move-result-object p1

    invoke-direct {p0, p1, p2, p3}, Lcom/aliyun/emas/apm/components/Dependency;-><init>(Lcom/aliyun/emas/apm/components/Qualified;II)V

    return-void
.end method

.method public static a(I)Ljava/lang/String;
    .locals 3

    if-eqz p0, :cond_2

    const/4 v0, 0x1

    if-eq p0, v0, :cond_1

    const/4 v0, 0x2

    if-ne p0, v0, :cond_0

    const-string p0, "deferred"

    return-object p0

    .line 3
    :cond_0
    new-instance v0, Ljava/lang/AssertionError;

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "Unsupported injection: "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-direct {v0, p0}, Ljava/lang/AssertionError;-><init>(Ljava/lang/Object;)V

    throw v0

    :cond_1
    const-string p0, "provider"

    return-object p0

    :cond_2
    const-string p0, "direct"

    return-object p0
.end method

.method public static deferred(Lcom/aliyun/emas/apm/components/Qualified;)Lcom/aliyun/emas/apm/components/Dependency;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/aliyun/emas/apm/components/Qualified<",
            "*>;)",
            "Lcom/aliyun/emas/apm/components/Dependency;"
        }
    .end annotation

    .line 2
    new-instance v0, Lcom/aliyun/emas/apm/components/Dependency;

    const/4 v1, 0x0

    const/4 v2, 0x2

    invoke-direct {v0, p0, v1, v2}, Lcom/aliyun/emas/apm/components/Dependency;-><init>(Lcom/aliyun/emas/apm/components/Qualified;II)V

    return-object v0
.end method

.method public static deferred(Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Dependency;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;)",
            "Lcom/aliyun/emas/apm/components/Dependency;"
        }
    .end annotation

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/components/Dependency;

    const/4 v1, 0x0

    const/4 v2, 0x2

    invoke-direct {v0, p0, v1, v2}, Lcom/aliyun/emas/apm/components/Dependency;-><init>(Ljava/lang/Class;II)V

    return-object v0
.end method

.method public static optional(Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Dependency;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;)",
            "Lcom/aliyun/emas/apm/components/Dependency;"
        }
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/components/Dependency;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1, v1}, Lcom/aliyun/emas/apm/components/Dependency;-><init>(Ljava/lang/Class;II)V

    return-object v0
.end method

.method public static optionalProvider(Lcom/aliyun/emas/apm/components/Qualified;)Lcom/aliyun/emas/apm/components/Dependency;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/aliyun/emas/apm/components/Qualified<",
            "*>;)",
            "Lcom/aliyun/emas/apm/components/Dependency;"
        }
    .end annotation

    .line 2
    new-instance v0, Lcom/aliyun/emas/apm/components/Dependency;

    const/4 v1, 0x0

    const/4 v2, 0x1

    invoke-direct {v0, p0, v1, v2}, Lcom/aliyun/emas/apm/components/Dependency;-><init>(Lcom/aliyun/emas/apm/components/Qualified;II)V

    return-object v0
.end method

.method public static optionalProvider(Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Dependency;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;)",
            "Lcom/aliyun/emas/apm/components/Dependency;"
        }
    .end annotation

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/components/Dependency;

    const/4 v1, 0x0

    const/4 v2, 0x1

    invoke-direct {v0, p0, v1, v2}, Lcom/aliyun/emas/apm/components/Dependency;-><init>(Ljava/lang/Class;II)V

    return-object v0
.end method

.method public static required(Lcom/aliyun/emas/apm/components/Qualified;)Lcom/aliyun/emas/apm/components/Dependency;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/aliyun/emas/apm/components/Qualified<",
            "*>;)",
            "Lcom/aliyun/emas/apm/components/Dependency;"
        }
    .end annotation

    .line 2
    new-instance v0, Lcom/aliyun/emas/apm/components/Dependency;

    const/4 v1, 0x1

    const/4 v2, 0x0

    invoke-direct {v0, p0, v1, v2}, Lcom/aliyun/emas/apm/components/Dependency;-><init>(Lcom/aliyun/emas/apm/components/Qualified;II)V

    return-object v0
.end method

.method public static required(Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Dependency;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;)",
            "Lcom/aliyun/emas/apm/components/Dependency;"
        }
    .end annotation

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/components/Dependency;

    const/4 v1, 0x1

    const/4 v2, 0x0

    invoke-direct {v0, p0, v1, v2}, Lcom/aliyun/emas/apm/components/Dependency;-><init>(Ljava/lang/Class;II)V

    return-object v0
.end method

.method public static requiredProvider(Lcom/aliyun/emas/apm/components/Qualified;)Lcom/aliyun/emas/apm/components/Dependency;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/aliyun/emas/apm/components/Qualified<",
            "*>;)",
            "Lcom/aliyun/emas/apm/components/Dependency;"
        }
    .end annotation

    .line 2
    new-instance v0, Lcom/aliyun/emas/apm/components/Dependency;

    const/4 v1, 0x1

    invoke-direct {v0, p0, v1, v1}, Lcom/aliyun/emas/apm/components/Dependency;-><init>(Lcom/aliyun/emas/apm/components/Qualified;II)V

    return-object v0
.end method

.method public static requiredProvider(Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Dependency;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;)",
            "Lcom/aliyun/emas/apm/components/Dependency;"
        }
    .end annotation

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/components/Dependency;

    const/4 v1, 0x1

    invoke-direct {v0, p0, v1, v1}, Lcom/aliyun/emas/apm/components/Dependency;-><init>(Ljava/lang/Class;II)V

    return-object v0
.end method

.method public static setOf(Lcom/aliyun/emas/apm/components/Qualified;)Lcom/aliyun/emas/apm/components/Dependency;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/aliyun/emas/apm/components/Qualified<",
            "*>;)",
            "Lcom/aliyun/emas/apm/components/Dependency;"
        }
    .end annotation

    .line 2
    new-instance v0, Lcom/aliyun/emas/apm/components/Dependency;

    const/4 v1, 0x2

    const/4 v2, 0x0

    invoke-direct {v0, p0, v1, v2}, Lcom/aliyun/emas/apm/components/Dependency;-><init>(Lcom/aliyun/emas/apm/components/Qualified;II)V

    return-object v0
.end method

.method public static setOf(Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Dependency;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;)",
            "Lcom/aliyun/emas/apm/components/Dependency;"
        }
    .end annotation

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/components/Dependency;

    const/4 v1, 0x2

    const/4 v2, 0x0

    invoke-direct {v0, p0, v1, v2}, Lcom/aliyun/emas/apm/components/Dependency;-><init>(Ljava/lang/Class;II)V

    return-object v0
.end method

.method public static setOfProvider(Lcom/aliyun/emas/apm/components/Qualified;)Lcom/aliyun/emas/apm/components/Dependency;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/aliyun/emas/apm/components/Qualified<",
            "*>;)",
            "Lcom/aliyun/emas/apm/components/Dependency;"
        }
    .end annotation

    .line 2
    new-instance v0, Lcom/aliyun/emas/apm/components/Dependency;

    const/4 v1, 0x2

    const/4 v2, 0x1

    invoke-direct {v0, p0, v1, v2}, Lcom/aliyun/emas/apm/components/Dependency;-><init>(Lcom/aliyun/emas/apm/components/Qualified;II)V

    return-object v0
.end method

.method public static setOfProvider(Ljava/lang/Class;)Lcom/aliyun/emas/apm/components/Dependency;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;)",
            "Lcom/aliyun/emas/apm/components/Dependency;"
        }
    .end annotation

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/components/Dependency;

    const/4 v1, 0x2

    const/4 v2, 0x1

    invoke-direct {v0, p0, v1, v2}, Lcom/aliyun/emas/apm/components/Dependency;-><init>(Ljava/lang/Class;II)V

    return-object v0
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 3

    .line 1
    instance-of v0, p1, Lcom/aliyun/emas/apm/components/Dependency;

    const/4 v1, 0x0

    if-eqz v0, :cond_0

    .line 2
    check-cast p1, Lcom/aliyun/emas/apm/components/Dependency;

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/Dependency;->a:Lcom/aliyun/emas/apm/components/Qualified;

    .line 3
    iget-object v2, p1, Lcom/aliyun/emas/apm/components/Dependency;->a:Lcom/aliyun/emas/apm/components/Qualified;

    invoke-virtual {v0, v2}, Lcom/aliyun/emas/apm/components/Qualified;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget v0, p0, Lcom/aliyun/emas/apm/components/Dependency;->b:I

    iget v2, p1, Lcom/aliyun/emas/apm/components/Dependency;->b:I

    if-ne v0, v2, :cond_0

    iget v0, p0, Lcom/aliyun/emas/apm/components/Dependency;->c:I

    iget p1, p1, Lcom/aliyun/emas/apm/components/Dependency;->c:I

    if-ne v0, p1, :cond_0

    const/4 v1, 0x1

    :cond_0
    return v1
.end method

.method public getInterface()Lcom/aliyun/emas/apm/components/Qualified;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lcom/aliyun/emas/apm/components/Qualified<",
            "*>;"
        }
    .end annotation

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/Dependency;->a:Lcom/aliyun/emas/apm/components/Qualified;

    return-object v0
.end method

.method public hashCode()I
    .locals 3

    iget-object v0, p0, Lcom/aliyun/emas/apm/components/Dependency;->a:Lcom/aliyun/emas/apm/components/Qualified;

    .line 1
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/components/Qualified;->hashCode()I

    move-result v0

    const v1, 0xf4243

    xor-int/2addr v0, v1

    mul-int/2addr v0, v1

    iget v2, p0, Lcom/aliyun/emas/apm/components/Dependency;->b:I

    xor-int/2addr v0, v2

    mul-int/2addr v0, v1

    iget v1, p0, Lcom/aliyun/emas/apm/components/Dependency;->c:I

    xor-int/2addr v0, v1

    return v0
.end method

.method public isDeferred()Z
    .locals 2

    iget v0, p0, Lcom/aliyun/emas/apm/components/Dependency;->c:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public isDirectInjection()Z
    .locals 1

    iget v0, p0, Lcom/aliyun/emas/apm/components/Dependency;->c:I

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public isRequired()Z
    .locals 2

    iget v0, p0, Lcom/aliyun/emas/apm/components/Dependency;->b:I

    const/4 v1, 0x1

    if-ne v0, v1, :cond_0

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    return v1
.end method

.method public isSet()Z
    .locals 2

    iget v0, p0, Lcom/aliyun/emas/apm/components/Dependency;->b:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    .line 1
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Dependency{anInterface="

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/aliyun/emas/apm/components/Dependency;->a:Lcom/aliyun/emas/apm/components/Qualified;

    .line 3
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", type="

    .line 4
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/aliyun/emas/apm/components/Dependency;->b:I

    const/4 v2, 0x1

    if-ne v1, v2, :cond_0

    const-string v1, "required"

    goto :goto_0

    :cond_0
    if-nez v1, :cond_1

    const-string v1, "optional"

    goto :goto_0

    :cond_1
    const-string v1, "set"

    .line 5
    :goto_0
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", injection="

    .line 6
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/aliyun/emas/apm/components/Dependency;->c:I

    .line 7
    invoke-static {v1}, Lcom/aliyun/emas/apm/components/Dependency;->a(I)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string/jumbo v1, "}"

    .line 8
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 9
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
